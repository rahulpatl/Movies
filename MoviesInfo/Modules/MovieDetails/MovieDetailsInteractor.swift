//
//  MovieDetailsInteractor.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import Foundation

class MovieDetailsInteractor {
  let presenter: MovieDetailsInteractorOutputProtocol?
  let netework: NetworkUtils!
  
  init(_presenter: MovieDetailsInteractorOutputProtocol) {
    presenter = _presenter
    netework = NetworkUtils()
  }
  
  func getMovieBy(id: Int) {
    let url = URLGenerator(dataType: .MOVIE_DETAILS).URLString + id.description
    netework.getData(url: url, object: MovieDetailsModel.self) { [weak self] (model) in
      guard let self = self else {
        return
      }
      if let _model = model {
        self.presenter?.updateDetailsOf(movie: _model)
      } else {
        self.presenter?.apiError(title: "Alert", message: "Please check your internet connection.")
      }
    }
  }
}
