//
//  FavoriteMovie.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 18/10/24.
//

import SwiftData

@Model
class FavoriteMovie{
  var id: Int
  var title: String
  var overview: String
  var posterPath: String
  var backdropPath: String
  var voteAverage: Double
  
  init(id: Int, title: String, overview: String, posterPath: String, backdropPath: String, voteAverage: Double) {
    self.id = id
    self.title = title
    self.overview = overview
    self.posterPath = posterPath
    self.backdropPath = backdropPath
    self.voteAverage = voteAverage
    
  }
}
