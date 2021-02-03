//
//  ViewController.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 29/01/21.
//

import UIKit

class MoviesListVC: UIViewController {
  private lazy var layout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    let width = (view.bounds.width / 2) - 8
    let height = width + (width / 2)
    layout.itemSize = CGSize(width: width, height: height)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 4
    return layout
  }()
  
  private lazy var collectionView: UICollectionView = {
    let collection = UICollectionView(frame: view.bounds, collectionViewLayout: self.layout)
    collection.register(UINib(nibName: "MovieInfoCell", bundle: nil), forCellWithReuseIdentifier: "MovieInfoCell")
    collection.contentInset = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
    collection.delegate = self
    collection.dataSource = self
    collection.scrollsToTop = true
    collection.backgroundColor = .black
    return collection
  }()
  
  private lazy var activity: UIActivityIndicatorView = {
    let centerX = (view.bounds.width / 2) - 15
    let centerY = (view.bounds.height / 2) - 15
    let activity = UIActivityIndicatorView(frame: CGRect(x: centerX, y: centerY, width: 30, height: 30))
    activity.color = .white
    return activity
  }()
  
  private lazy var searchBar: UISearchBar = {
    let search = UISearchBar()
    search.searchBarStyle = UISearchBar.Style.prominent
    search.placeholder = " Search..."
    search.sizeToFit()
    search.isTranslucent = false
    search.backgroundImage = UIImage()
    search.delegate = self
    return search
  }()
  
  private var viewModel = MovieListViewModel()
  private var presenter: MoviesListPresenterProtocol?
  
  convenience init(movies: [MoviesList]) {
    self.init()
    viewModel.enableSearch = true
    viewModel.append(movies: movies)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViews()
    setUpPresenter()
    setUpNavigationBar()
  }
  
  private func setUpViews() {
    view.addSubview(collectionView)
    view.addSubview(activity)
  }
  
  private func setUpNavigationBar() {
    extendedLayoutIncludesOpaqueBars = true
    title = "Movies"
    if viewModel.enableSearch {
      navigationItem.titleView = searchBar
    } else {
      let sortBy = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(showActionSheet))
      navigationItem.leftBarButtonItems = [sortBy]
      
      let searchController = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(openSearchController))
      navigationItem.rightBarButtonItems = [searchController]
    }
  }
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  @objc private func openSearchController() {
    let movies = DefaultStorage.shared.getMovieList()
    let vc = MoviesListVC(movies: movies)
    navigationController?.pushViewController(vc, animated: true)
  }
  
  @objc private func showActionSheet() {
    let actionSheet = UIAlertController(title: "Sort", message: "Prefer you order.", preferredStyle: .actionSheet)
    let popularity = UIAlertAction(title: "By Popularity", style: .default) { [weak self] (action) in
      self?.prepareRequest(type: .POPULARITY_DESC)
    }
    actionSheet.addAction(popularity)
    
    let revenue = UIAlertAction(title: "By Revenue", style: .default) { [weak self] (action) in
      self?.prepareRequest(type: .REVENUE_DESC)
    }
    actionSheet.addAction(revenue)
    
    let release = UIAlertAction(title: "By Release", style: .default) { [weak self] (action) in
      self?.prepareRequest(type: .RELEASE_DESC)
    }
    actionSheet.addAction(release)
    
    let voteAvg = UIAlertAction(title: "By Voting Average", style: .default) { [weak self] (action) in
      self?.prepareRequest(type: .VOTE_AVG_DESC)
    }
    actionSheet.addAction(voteAvg)
    
    let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { _ in }
    actionSheet.addAction(dismiss)
    present(actionSheet, animated: true)
  }
  
  private func setUpPresenter() {
    presenter = MoviesListPresenter(_view: self)
    prepareRequest(type: .POPULARITY_DESC)
  }
  
  private func prepareRequest(type: DISCOVER) {
    if !viewModel.enableSearch {
      activity.startAnimating()
      viewModel.discover = type
      collectionView.reloadData()
      presenter?.get(page: viewModel.currentPage, for: type)
    }
  }
}

extension MoviesListVC: MoviesListViewProtocol {
  func apiError(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in }))
    present(alert, animated: true)
  }
  
  func update(_list: [MoviesList], currentPage: Int) {
    viewModel.currentPage = currentPage
    collectionView.performBatchUpdates {
      let lastCount = viewModel.getListCount()
      viewModel.append(movies: _list)
      DefaultStorage.shared.storeMovie(list: viewModel.list)
      collectionView.insertItems(at: (lastCount..<viewModel.getListCount()).map {
        return IndexPath(item: $0, section: 0)
      })
    } completion: { [weak self] (isCompleted) in
      if isCompleted {
        self?.collectionView.reloadData()
      }
    }
    activity.stopAnimating()
  }
}

extension MoviesListVC: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getListCount()
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let model = viewModel.get(indexPath: indexPath)
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieInfoCell", for: indexPath) as? MovieInfoCell
    cell?.updateMovie(of: model)
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.item == (viewModel.getListCount() - 1), !activity.isAnimating, !viewModel.isLocalSearchOn, !viewModel.enableSearch {
      activity.startAnimating()
      presenter?.get(page: viewModel.currentPage+1, for: viewModel.discover)
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = MovieDetailsVC(movieId: viewModel.get(indexPath: indexPath).id!)
    let nc = UINavigationController(rootViewController: vc)
    nc.modalPresentationStyle = .fullScreen
    present(nc, animated: true)
  }
}

extension MoviesListVC: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    viewModel.search(text: searchText)
    collectionView.reloadData()
  }
}
