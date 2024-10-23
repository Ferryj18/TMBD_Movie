//
//  MovieDetails.swift
//  TMBD Movies App
//
//  Created by Ferry jati on 24/09/24.
//
import SwiftUI
import SwiftData

struct MovieDetailView: View{
  
  @Environment(\.modelContext) var modelContext
  @State var movieID: String = ""
  @State var movie: DetailMoviesResponse? = nil
  @State var isFavorite : Bool = false
  var body: some View{
    ScrollView{
      VStack{
        if let movieBackdropCover = movie?.backdropPath {
          AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/original/\(movieBackdropCover)")) {
            imageView in
            //image dari internet
            imageView
              .resizable()
              .scaledToFit()
              .frame(width: .infinity)
            
          }placeholder: {
            //gambar sementara
            Image("MovieCover")
              .resizable()
              .scaledToFit()
              .frame(width: .infinity)
          }
          
        }
        HStack (spacing:10) {
          ForEach (movie?.genres ?? [], id:\.self) { genre in
            Text(genre.name)
              .font(.subheadline)
              .bold()
          }
        }
        Text(movie?.title ?? "Movie Title")
          .font(.title2)
          .bold()
        Text("\(movie?.releaseDate ?? "1 Jan 2020") - \(movie?.runtime ?? 0) min")
          .font(.caption)
          .foregroundStyle(.secondary)
          .padding(.bottom,10)
        Button{
          
        } label:{
          Text("Subscribe")
            .fontWeight(.medium)
            .padding(.horizontal,60)
            .padding(.vertical,10)
            .background(Color("subsribeButtonColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
        Text("Rp.99.00/month until cancelled.")
          .font(.caption)
          .foregroundStyle(.secondary)
          .padding(.top,5)
        Divider()
          .padding(15)
        Text(movie?.overview ?? "movie description")
          .frame(maxWidth: .infinity,alignment: .leading)
        
        Spacer()
      }
    }
    .toolbar{
      ToolbarItem{
        Button{
          if isFavorite{
            removeFavorite(id: Int(movieID)!)
            
          }else{
            addToFavorite()
          }
        }label: {
          Image(systemName: isFavorite ? "star.fill": "star")
        }
      }
    }
    .onAppear{
      fetchMovieDetail(movieID: movieID)
      isFavorite = checkIsFavorite(id: Int(movieID)!)
    }
  }
  func addToFavorite(){
    guard let movie = movie else {return}
    
    let favoriteMovie = FavoriteMovie(id: movie.id,
                                      title: movie.title,
                                      overview: movie.overview,
                                      posterPath: movie.posterPath ?? "",
                                      backdropPath: movie.backdropPath ?? "",
                                      voteAverage: movie.voteAverage)
    modelContext.insert(favoriteMovie)
    isFavorite = true
    print("add to favorite")
}
  func removeFavorite(id: Int){
    do{
      let descriptor = FetchDescriptor<FavoriteMovie>(predicate: #Predicate<FavoriteMovie>{ movie in
        movie.id == id
      })
      let result = try modelContext.fetch(descriptor)
      if let favoriteMovie = result.first{
        modelContext.delete(favoriteMovie)
        isFavorite = false
      }
      }catch{
      print("Error: \(error.localizedDescription)")
    }
  }
  func checkIsFavorite(id: Int) -> Bool{
    do{
      let descriptor = FetchDescriptor<FavoriteMovie>(predicate: #Predicate<FavoriteMovie> { movie in
        movie.id == id
      }, sortBy: [])
      let result = try modelContext.fetch(descriptor)
      return !result.isEmpty
    }catch{
      print("Failed to check \(error.localizedDescription)")
      return false
    }
    
  }
  func fetchMovieDetail(movieID: String){

    
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)")
    let headers = [
      "Accept" : "application/json",
      "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4ODNiMjA2NjFjMzVmMzhlMTgxMjQzZjczNjFmMjhmMyIsIm5iZiI6MTcyNzUzMTI0NC45MDkxNTcsInN1YiI6IjY2ZWFlZmYxNTE2OGE4OTZlMTFmNzRjMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.usLsgbnWvf5-5TO0vUPGi1QKDoXHLYn1at8OQbYWU8k"
    ]
    var request = URLRequest(url: url!)
    for (key, value) in headers {
      request.setValue(value,  forHTTPHeaderField: key)
    }
    URLSession.shared.dataTask(with: request) { data, response, error in
      //handle response / error / data
      if error != nil{
        print (error?.localizedDescription)
        return
      } 
      print(String(data: data!, encoding: .utf8))
      do{
        let apiData = try JSONDecoder().decode(DetailMoviesResponse.self, from: data!)
        print(apiData.originalTitle)
        //assign apiData ke movie state variable
        self.movie = apiData
      }catch{
        print(error.localizedDescription)
      }
    }
    .resume()
  }
    
}
  
#Preview {
  MovieDetailView()
}
