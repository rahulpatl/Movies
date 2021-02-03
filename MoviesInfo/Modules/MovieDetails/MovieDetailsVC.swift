//
//  MovieDetailsVC.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import UIKit

class MovieDetailsVC: UIViewController {
  private lazy var tableView: UITableView = {
    let tableView = UITableView()
//    tableView.delegate = self
    tableView.dataSource = self
    tableView.backgroundColor = .black
    tableView.register(UINib(nibName: "PosterCell", bundle: nil), forCellReuseIdentifier: "PosterCell")
    tableView.register(UINib(nibName: "OverviewCell", bundle: nil), forCellReuseIdentifier: "OverviewCell")
    tableView.register(UINib(nibName: "TitleCell", bundle: nil), forCellReuseIdentifier: "TitleCell")
    tableView.register(UINib(nibName: "OtherDetailsCell", bundle: nil), forCellReuseIdentifier: "OtherDetailsCell")
    return tableView
  }()
  private var viewModel = MovieDetailsViewModel()
  private var presener: MovieDetailsPresenter?
  
  convenience init(movieId: Int) {
    self.init()
    viewModel.movieId = movieId
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpNavigationBar()
    setUpViews()
    setUpPresenter()
  }
  
  private func setUpNavigationBar() {
    title = "Details"
    let closeButton = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(closeTapped))
    navigationItem.leftBarButtonItem = closeButton
  }
  
  @objc private func closeTapped() {
    dismiss(animated: true)
  }
  
  private func setUpViews() {
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  private func setUpPresenter() {
    presener = MovieDetailsPresenter(_view: self)
    presener?.getDetailsForMovie(id: viewModel.movieId!)
  }
}

extension MovieDetailsVC: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = viewModel.getData(for: indexPath.row)
    switch model.type {
    case .Poster:
      let cell = tableView.dequeueReusableCell(withIdentifier: "PosterCell", for: indexPath) as? PosterCell
      cell?.updateMovie(data: model)
      return cell!
    
    case .Title:
      let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell
      cell?.setUp(data: model)
      return cell!
    
    case .Plot:
      let cell = tableView.dequeueReusableCell(withIdentifier: "OverviewCell", for: indexPath) as? OverviewCell
      cell?.setUp(data: model)
      return cell!
      
    default:
      let cell = tableView.dequeueReusableCell(withIdentifier: "OtherDetailsCell", for: indexPath) as? OtherDetailsCell
      cell?.updateMovie(data: model)
      return cell!
    }
  }
}

extension MovieDetailsVC: MovieDetailsViewProtocol {
  func updateDetailsOf(movie: MovieDetailsModel) {
    viewModel.prepareData(for: movie)
    tableView.reloadData()
  }
  
  func apiError(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { _ in }))
    present(alert, animated: true)
  }
}
