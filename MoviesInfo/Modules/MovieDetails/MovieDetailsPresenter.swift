//
//  MovieDetailsPresenter.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import Foundation
protocol MovieDetailsViewProtocol: class {
  func updateDetailsOf(movie: MovieDetailsModel)
  func apiError(title: String, message: String)
}

protocol MovieDetailsPresenterProtocol: class {
  func getDetailsForMovie(id: Int)
}

protocol MovieDetailsInteractorOutputProtocol: class {
  func updateDetailsOf(movie: MovieDetailsModel)
  func apiError(title: String, message: String)
}

class MovieDetailsPresenter {
  private weak var view: MovieDetailsViewProtocol?
  private var interactor: MovieDetailsInteractor?
  
  init(_view: MovieDetailsViewProtocol) {
    view = _view
    interactor = MovieDetailsInteractor(_presenter: self)
  }
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
  func getDetailsForMovie(id: Int) {
    interactor?.getMovieBy(id: id)
  }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutputProtocol {
  func apiError(title: String, message: String) {
    view?.apiError(title: title, message: message)
  }
  
  func updateDetailsOf(movie: MovieDetailsModel) {
    view?.updateDetailsOf(movie: movie)
  }
}
