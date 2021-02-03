//
//  MoviesListPresenter.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 29/01/21.
//

import Foundation

protocol MoviesListViewProtocol: class {
  func update(_list: [MoviesList], currentPage: Int)
  func apiError(title: String, message: String)
}

protocol MoviesListPresenterProtocol: class {
  func get(page: Int, for discovery: DISCOVER)
}

protocol MoviesListInteractorOutputProtocol: class {
  func update(model: MoviesListModel)
  func apiError(title: String, message: String)
}

class MoviesListPresenter {
  private weak var view: MoviesListViewProtocol?
  private var interactor: MoviesListInteractor?
  
  init(_view: MoviesListViewProtocol) {
    self.view = _view
    interactor = MoviesListInteractor(_presenter: self)
  }
}

extension MoviesListPresenter: MoviesListPresenterProtocol {
  func get(page: Int, for discovery: DISCOVER) {
    interactor?.get(page: page, for: discovery)
  }
}

extension MoviesListPresenter: MoviesListInteractorOutputProtocol {
  func apiError(title: String, message: String) {
    view?.apiError(title: title, message: message)
  }
  
  func update(model: MoviesListModel) {
    view?.update(_list: model.results!, currentPage: model.page!)
  }
}
