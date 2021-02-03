//
//  MovieDatailsModel.swift
//  MoviesInfo
//
//  Created by Rahul Patil on 01/02/21.
//

import Foundation

struct MovieDetailsModel: Codable {
  var budget: Double?
  var genres: [MovieGenre]?
  var id: Int?
  var originalLanguage: String?
  var originalTitle: String?
  var overview: String?
  var popularity: Double?
  var posterPath: String?
  var productionCompanies: [MovieGenre]?
  var releaseDate: String?
  var revenue: Double?
  var runtime: Int?
  var tagline: String?
  var title: String?
  var voteAverage: Double?
  
  enum CodingKeys: String, CodingKey {
    case budget = "budget"
    case genres = "genres"
    case id = "id"
    case originalLanguage = "original_language"
    case originalTitle = "original_title"
    case overview = "overview"
    case popularity = "popularity"
    case posterPath = "poster_path"
    case productionCompanies = "production_companies"
    case releaseDate = "release_date"
    case revenue = "revenue"
    case runtime = "runtime"
    case tagline = "tagline"
    case title = "title"
    case voteAverage = "vote_average"
  }
  
  init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    budget = try? values?.decode(Double.self, forKey: .budget)
    genres = try? values?.decode([MovieGenre].self, forKey: .genres)
    id = try? values?.decode(Int.self, forKey: .id)
    originalLanguage = try? values?.decode(String.self, forKey: .originalLanguage)
    originalTitle = try? values?.decode(String.self, forKey: .originalTitle)
    overview = try? values?.decode(String.self, forKey: .overview)
    popularity = try? values?.decode(Double.self, forKey: .popularity)
    posterPath = try? values?.decode(String.self, forKey: .posterPath)
    productionCompanies = try? values?.decode([MovieGenre].self, forKey: .productionCompanies)
    releaseDate = try? values?.decode(String.self, forKey: .releaseDate)
    revenue = try? values?.decode(Double.self, forKey: .revenue)
    runtime = try? values?.decode(Int.self, forKey: .runtime)
    tagline = try? values?.decode(String.self, forKey: .tagline)
    title = try? values?.decode(String.self, forKey: .title)
    voteAverage = try? values?.decode(Double.self, forKey: .voteAverage)
  }
}

struct MovieGenre: Codable {
  var id: Int?
  var name: String?
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
  }
  
  init(from decoder: Decoder) throws {
    let values = try? decoder.container(keyedBy: CodingKeys.self)
    id = try? values?.decode(Int.self, forKey: .id)
    name = try? values?.decode(String.self, forKey: .name)
  }
}
