//
//  Video.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import Foundation

struct VideoResponse: Decodable {
    let results: [Video]
}

struct Video: Decodable {
    let id: String
    let iso639_1: String
    let iso3166_1: String
    let name: String
    let key: String  // Use this key to play the video
    let site: String // E.g., "YouTube"
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name
        case key
        case site
        case size
        case type
        case official
        case publishedAt = "published_at"
    }
}
