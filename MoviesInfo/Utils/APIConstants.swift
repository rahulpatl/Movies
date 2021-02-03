//
//  APIConstants.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 30/01/21.
//

import Foundation

class URLGenerator {
  var URLString = ""
  private let domain = "https://api.themoviedb.org/3/"
  init(sortType: DISCOVER) {
    URLString = domain + sortType.rawValue
  }
  
  init(dataType: DataType) {
    URLString = domain + dataType.rawValue
  }
}

enum DataType: String {
  case GENRE = "genre/movie/list"
  case MOVIE_DETAILS = "movie/"
}

enum DISCOVER: String {
  case POPULARITY_DESC = "discover/movie?sort_by=popularity.desc"
  case REVENUE_DESC = "discover/movie?sort_by=revenue.desc"
  case RELEASE_DESC = "discover/movie?sort_by=release_date.desc"
  case VOTE_AVG_DESC = "discover/movie?sort_by=vote_average.desc"
}
