//
//  Cast.swift
//  MovieApp
//
//  Created by Abhijeet Nag on 29/10/24.
//

import Foundation

struct CastMember: Identifiable, Decodable {
    let id: Int
    let name: String
    let profilePath: String?
    let character: String
    let knownForDepartment: String

    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w200" + path)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case profilePath = "profile_path"
        case character
        case knownForDepartment = "known_for_department"
    }
}

struct CrewMember: Identifiable, Decodable {
    let id: Int
    let name: String
    let job: String
    let profilePath: String?
    
    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w200" + path)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case job
        case profilePath = "profile_path"
    }
}

struct CastResponse: Decodable {
    let cast: [CastMember]
    let crew: [CrewMember]
}
