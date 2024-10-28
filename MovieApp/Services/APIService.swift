//
//  APIService.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let apiKey = "{API_KEY}"  // Replace with your actual TMDb API Key
    private let baseURL = "https://api.themoviedb.org/3/movie"
    
    func fetchPopularMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(baseURL)/popular?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, _, error) in
            if let error = error {
                print("Network error(fetchPopularMovies): \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.results)
                }
            } catch {
                print("Failed to decode response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchMovieDetails(id: Int, completion: @escaping (Movie) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, _, error) in
            if let error = error {
                print("Network error(fetchMovieDetails): \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
                        
            do {
                let movie = try JSONDecoder().decode(Movie.self, from: data)
                DispatchQueue.main.async {
                    completion(movie)
                }
            } catch {
                print("Failed to decode movie details: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    func fetchMovieTrailer(id: Int, completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)/videos?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, _, error) in
            if let error = error {
                print("Network error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                // Look for the first official YouTube trailer
                if let trailerKey = response.results.first(where: { $0.site == "YouTube" && $0.type == "Trailer" })?.key {
                    DispatchQueue.main.async {
                        completion(trailerKey)
                    }
                } else {
                    print("No YouTube trailer found")
                    completion(nil)
                }
            } catch {
                print("Failed to decode trailer response: \(error.localizedDescription)")
            }
        }.resume()
    }
    
    
    // Method to fetch cast for a specific movie
    func fetchMovieCast(id: Int, completion: @escaping ([CastMember]) -> Void) {
        guard let url = URL(string: "\(baseURL)/\(id)/credits?api_key=\(apiKey)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data: Data?, _, error) in
            if let error = error {
                print("Failed to fetch cast: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received for cast")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CastResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.cast)
                }
            } catch {
                print("Failed to decode cast: \(error.localizedDescription)")
            }
        }.resume()
    }

}
