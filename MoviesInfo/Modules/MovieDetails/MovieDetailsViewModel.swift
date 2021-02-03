//
//  MovieDetailsViewModel.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import Foundation

struct MovieDetailsViewModel {
  var movieDetails: MovieDetailsModel?
  var movieId: Int?
  var data = [MovieData]()
  
  mutating func prepareData(for movie: MovieDetailsModel) {
    movieDetails = movie
    data.removeAll()
    var titleCell = MovieData()
    titleCell.type = .Title
    titleCell.title = movieDetails?.title
    titleCell.value = movieDetails?.originalTitle
    data.append(titleCell)
    
    var posterCell = MovieData()
    posterCell.type = .Poster
    posterCell.value = movieDetails?.posterPath
    data.append(posterCell)
    
    var plotCell = MovieData()
    plotCell.type = .Plot
    plotCell.value = movieDetails?.overview ?? "-"
    data.append(plotCell)
    
    var ratingCell = MovieData()
    ratingCell.type = .Other
    ratingCell.title = "Average Vote:"
    ratingCell.value = "\(movieDetails?.voteAverage?.description ?? "0") / 10"
    data.append(ratingCell)
    
    var genresCell = MovieData()
    genresCell.type = .Other
    genresCell.title = "Genres:"
    if let genres = movieDetails?.genres, !genres.isEmpty {
      genresCell.value = ""
      for i in 0..<genres.count {
        genresCell.value?.append(genres[i].name!)
        genresCell.value?.append(i < (genres.count-1) ? ", " : "")
      }
    } else {
      genresCell.value = "-"
    }
    data.append(genresCell)
    
    var runTimeCell = MovieData()
    runTimeCell.type = .Other
    runTimeCell.title = "Runtime:"
    runTimeCell.value = "\(movieDetails?.runtime?.description ?? "-") minutes"
    data.append(runTimeCell)
    
    if let tagline = movieDetails?.tagline, !tagline.isEmpty {
      var taglineCell = MovieData()
      taglineCell.type = .Other
      taglineCell.title = "Tagline:"
      taglineCell.value = tagline
      data.append(taglineCell)
    }
    
    var budgetCell = MovieData()
    budgetCell.type = .Other
    budgetCell.title = "Budget:"
    if let budget = movieDetails?.budget {
      budgetCell.value = "$" + budget.description
    } else {
      budgetCell.value = "-"
    }
    data.append(budgetCell)
    
    var revenueCell = MovieData()
    revenueCell.type = .Other
    revenueCell.title = "Revenue:"
    if let budget = movieDetails?.revenue {
      revenueCell.value = "$" + budget.description
    } else {
      revenueCell.value = "-"
    }
    data.append(revenueCell)
    
    var productionCell = MovieData()
    productionCell.type = .Other
    productionCell.title = "Production Companies:"
    if let genres = movieDetails?.productionCompanies, !genres.isEmpty {
      productionCell.value = ""
      for i in 0..<genres.count {
        productionCell.value?.append(genres[i].name!)
        productionCell.value?.append(i < (genres.count-1) ? ", " : "")
      }
    } else {
      productionCell.value = "-"
    }
    data.append(productionCell)
  }
  
  func getData(for index: Int) -> MovieData {
    return data[index]
  }
  
}

struct MovieData {
  var type: CellType?
  var value: String?
  var title: String?
  var index: Int?
}

enum CellType {
  case Title
  case Poster
  case Plot
  case Other
}
