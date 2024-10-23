//
//  ContentView.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 24/09/24.
//

import SwiftUI

struct ContentView: View {
  @State var tmpData = 1...10
  @State var popularMovies: [Movie] = []
  var body: some View {
    NavigationStack{
      List{
        ForEach(popularMovies, id: \.self) { data in
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
        .navigationTitle("Popular Movies")
        .navigationBarTitleDisplayMode(/*@START_MENU_TOKEN@*/.automatic/*@END_MENU_TOKEN@*/)
        .listStyle(.plain)
        .onAppear(perform: {
          fetchPopularMovies()
        })
      }
    }
  //network request
  func fetchPopularMovies() {
 // URL:  https://api.themoviedb.org/3/movie/popular
    /*  --header 'Authorization: Bearer
     Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ODNiMjA2NjFjMzVmMzhlMTgxMjQzZjczNjFmMjhmMyIsIm5iZiI6MTcyNzUzMTI0NC45MDkxNTcsInN1YiI6IjY2ZWFlZmYxNTE2OGE4OTZlMTFmNzRjMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.usLsgbnWvf5-5TO0vUPGi1QKDoXHLYn1at8OQbYWU8k
     \
     --header 'accept: application/json'
     */
    let url = URL(string: "https://api.themoviedb.org/3/movie/popular")
    let headers = [
      "Accept" : "application/json",
      "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ODNiMjA2NjFjMzVmMzhlMTgxMjQzZjczNjFmMjhmMyIsIm5iZiI6MTcyNzUzMTI0NC45MDkxNTcsInN1YiI6IjY2ZWFlZmYxNTE2OGE4OTZlMTFmNzRjMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.usLsgbnWvf5-5TO0vUPGi1QKDoXHLYn1at8OQbYWU8k"
    ]
    
    var request = URLRequest(url: url!)
    for (key, value) in headers {
      request.setValue(value, forHTTPHeaderField: key)
    }
    URLSession.shared.dataTask(with: request) { data, response, error
      in
      //handle response / error / data
      if error != nil{
        print (error?.localizedDescription)
        return
      }
      print(String(data: data!, encoding: .utf8))
      //decode the json data
      do{
        let apiData = try JSONDecoder().decode(PopularMoviesResponse.self, from: data!)
        print("Total Film: \(apiData.totalResults)")
        
        print(apiData.results)
        // assign results data to popular movies
        self.popularMovies = apiData.results
      } catch {
        print ("Ooopss.. something wrong: \(error.localizedDescription)")
      }
      
    }
        .resume()
  }
  
}
  #Preview {
    ContentView()
}
