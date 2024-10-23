//
//  FavoriteMovieListView.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 18/10/24.

import SwiftUI
import SwiftData

struct FavoriteMovieListView: View {
  @Query var favoriteMovies: [FavoriteMovie]
  
  var body: some View {
    NavigationStack{
      List{
        ForEach(favoriteMovies, id: \.self) { data in
          NavigationLink{
            MovieDetailView(movieID: "\(data.id)" )
          }label: {
            HStack{
              // image cover
              AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(data.backdropPath)")) { imageview in
                imageview
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100)
                  .clipShape(RoundedRectangle(cornerRadius: 10.10))
              } placeholder: {
                Image("PlaceholderImage")
                  .resizable()
                  .scaledToFit()
                  .frame(width: 100)
                  .clipShape(RoundedRectangle(cornerRadius: 10.10))
              }
              
              
              
              // title & genre
              VStack(alignment: .leading) {
                Text(data.title)
                Text(data.overview)
                  .foregroundStyle(.secondary )
              }
            }
            
            
          }
          //list item
          
        }
        
      }
      .navigationTitle("Favorite Movies")
      .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
      .listStyle(.plain)
    }
  }
}
  #Preview {
    FavoriteMovieListView()
}
