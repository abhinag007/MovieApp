//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import SwiftUI

struct MovieDetailView: View {
    let movieId: Int
    @State private var movie: Movie?
    @State private var trailerKey: String?
    @State private var cast: [CastMember] = []
    
    var body: some View {
        ScrollView {
            if let movie = movie {
                VStack(alignment: .leading, spacing: 20) {
                    // Video Player (YouTube Trailer)
                    if let trailerKey = trailerKey {
                        WebView(url: URL(string: "https://www.youtube.com/embed/\(trailerKey)")!)
                            .frame(height: 250)
                            .cornerRadius(8)
                            .padding(.bottom, 20)
                    }
                    
                    // Movie Title
                    Text(movie.title)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Rating and Duration
                    HStack {
                        Text("Rating: \(movie.voteAverage, specifier: "%.1f") / 10")
                            .font(.subheadline)
                        Spacer()
                        Text("Duration: \(movie.runtime ?? 0) mins")
                            .font(.subheadline)
                    }
                    .padding(.vertical, 5)
                    
                    // Genres
                    if let genres = movie.genres {
                        Text("Genres: " + genres.map { $0.name }.joined(separator: ", "))
                            .font(.subheadline)
                            .padding(.vertical, 5)
                    }
                    
                    // Plot
                    Text("Plot")
                        .font(.headline)
                        .padding(.top, 10)
                    
                    Text(movie.overview)
                        .font(.body)
                        .padding(.bottom, 10)
                    
                    // Cast
                    if !cast.isEmpty {
                        Text("Cast")
                            .font(.headline)
                            .padding(.top, 10)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(alignment: .top) {
                                ForEach(cast) { member in
                                    VStack {
                                        AsyncImage(url: member.profileURL) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 60, height: 90)
                                                .clipped()  // Ensures content fills the frame without overflow
                                                .cornerRadius(8)
                                        } placeholder: {
                                            // Add a placeholder if needed
                                            Color.gray
                                                .frame(width: 60, height: 90)
                                                .cornerRadius(8)
                                        };                                        Text(member.name)
                                            .font(.caption)
                                            .frame(width: 60)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .onAppear {
            fetchMovieDetails()
            fetchMovieTrailer()
            fetchCast()
        }
    }
    
    // Fetch movie details
    private func fetchMovieDetails() {
        APIService.shared.fetchMovieDetails(id: movieId) { movie in
            self.movie = movie
        }
    }
    
    // Fetch trailer key
    private func fetchMovieTrailer() {
        APIService.shared.fetchMovieTrailer(id: movieId) { key in
            self.trailerKey = key
        }
    }
    
    // Fetch cast
    private func fetchCast() {
        APIService.shared.fetchMovieCast(id: movieId) { cast in
            self.cast = cast
        }
    }
}
