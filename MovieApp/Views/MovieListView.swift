//
//  MovieListView.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import SwiftUI

struct MovieListView: View {
    @State private var movies = [Movie]()
    
    var body: some View {
        NavigationView {
            List(movies) { movie in
                NavigationLink(destination: MovieDetailView(movieId: movie.id)) {
                    HStack {
                        AsyncImage(url: movie.posterURL)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                            Text("Rating: \(movie.voteAverage, specifier: "%.1f")")
                                .font(.subheadline)
                            if let releaseDate = movie.releaseDate {
                                Text("Release Date: \(releaseDate)")
                                    .font(.subheadline)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Popular Movies")
            .onAppear {
                APIService.shared.fetchPopularMovies { movies in
                    self.movies = movies
                }
            }
        }
    }
}
