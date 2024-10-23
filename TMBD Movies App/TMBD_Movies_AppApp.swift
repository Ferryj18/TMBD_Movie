//
//  TMBD_Movies_AppApp.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 24/09/24.
//

import SwiftUI
import SwiftData

@main
struct TMBD_Movies_AppApp: App {
  var body: some Scene {
    WindowGroup {
      TabView{
        ContentView()
          .tabItem{
            Label("Popular", systemImage: "Film")
          }
        FavoriteMovieListView()
          .tabItem{
            Label("Favorite", systemImage: "popcorn")
          }
      }
      .modelContainer(for: FavoriteMovie.self)
    }
  }
}
