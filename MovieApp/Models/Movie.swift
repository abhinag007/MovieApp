//
//  Movie.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Movie: Identifiable, Decodable {
    let id: Int
    let title: String
    let overview: String
    let voteAverage: Double
    let posterPath: String?
    let releaseDate: String?
    let adult: Bool
    let backdropPath: String?
    let genres: [Genre]?
    let originalLanguage: String
    let originalTitle: String
    let popularity: Double
    let video: Bool
    let voteCount: Int
    let budget: Int?
    let homepage: String?
    let imdbID: String?
    let revenue: Int?
    let runtime: Int?
    let status: String?
    let tagline: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let spokenLanguages: [SpokenLanguage]?
    
    var posterURL: URL? {
        URL(string: "https://image.tmdb.org/t/p/w500" + (posterPath ?? ""))
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case adult
        case backdropPath = "backdrop_path"
        case genres
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case popularity
        case video
        case voteCount = "vote_count"
        case budget
        case homepage
        case imdbID = "imdb_id"
        case revenue
        case runtime
        case status
        case tagline
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case spokenLanguages = "spoken_languages"
    }
}


struct ProductionCompany: Decodable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Decodable {
    let iso3166_1: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Decodable {
    let englishName: String
    let iso639_1: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
