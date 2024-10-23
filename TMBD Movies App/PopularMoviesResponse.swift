//
//  PopularMoviesResponse.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 24/09/24.
//

import Foundation

struct PopularMoviesResponse: Decodable,Hashable {
  let page: Int
  let results: [Movie]
  let totalPages: Int
  let totalResults: Int
  
  enum CodingKeys: String, CodingKey{
    case page
    case results
    case totalPages = "total_pages"
    case totalResults = "total_results"
    
  }
  
}

struct Movie: Decodable, Hashable{
  let id: Int
  let title: String
  let overview: String
  let posterPath: String
  let backdropPath: String
  let voteAverage: Double
  
  enum CodingKeys:  String, CodingKey{
    case id
    case title
    case overview
    case posterPath = "poster_path"
    case backdropPath = "backdrop_path"
    case voteAverage =  "vote_average"
    
    
  }
}
