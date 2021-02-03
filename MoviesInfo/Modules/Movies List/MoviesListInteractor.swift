//
//  MoviesListInteractor.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 29/01/21.
//

import Foundation

class MoviesListInteractor {
  private weak var presenter: MoviesListInteractorOutputProtocol?
  let network: NetworkUtils?
  
  init(_presenter: MoviesListInteractorOutputProtocol) {
    presenter = _presenter
    network = NetworkUtils()
  }
  
  func get(page: Int, for discovery: DISCOVER) {
    let url = URLGenerator(sortType: discovery).URLString + "&page=\(page.description)"
    network?.getData(url: url, object: MoviesListModel.self, compilation: { [weak self] (model) in
      guard let self = self else {
        return
      }
      if let _model = model {
        self.presenter?.update(model: _model)
      } else {
        self.presenter?.apiError(title: "Alert", message: "Please check your internet connection.")
      }
    })
  }
}
