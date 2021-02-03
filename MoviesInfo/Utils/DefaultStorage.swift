//
//  DefaultStorage.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import Foundation

class DefaultStorage {
  static let shared = DefaultStorage()
  
  func storeMovie(list: [MoviesList]) {
    UserDefaults.standard.setValue(try? PropertyListEncoder().encode(list), forKey: "MovieList")
  }
  
  func getMovieList() -> [MoviesList] {
    if let data = UserDefaults.standard.value(forKey:"MovieList") as? Data,
       let list = try? PropertyListDecoder().decode(Array<MoviesList>.self, from: data) {
        return list
    }
    return []
  }
}
