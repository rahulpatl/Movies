//
//  MovieListViewModel.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 31/01/21.
//

import Foundation

struct MovieListViewModel {
  var list = [MoviesList]() {
    didSet {
      filteredList = list
    }
  }
  var filteredList = [MoviesList]()
  var currentPage = 1
  var enableSearch = false
  var discover: DISCOVER = .POPULARITY_DESC {
    didSet {
      list.removeAll()
      filteredList.removeAll()
      currentPage = 1
    }
  }
  var isLocalSearchOn = false
  
  func get(indexPath: IndexPath) -> MoviesList {
    return filteredList[indexPath.item]
  }
  
  mutating func append(movies: [MoviesList]) {
    list += movies
  }
  
  func getListCount() -> Int {
    return filteredList.count
  }
  
  mutating func search(text: String) {
    if !text.isEmpty {
      isLocalSearchOn = true
      filteredList = list.filter({ (movie) -> Bool in
        if movie.title!.lowercased().contains(text.lowercased()) {
          return true
        }
        return false
      })
    } else {
      isLocalSearchOn = false
      filteredList = list
    }
  }
}
