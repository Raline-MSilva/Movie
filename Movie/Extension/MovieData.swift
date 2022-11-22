//
//  MovieData.swift
//  Movie
//
//  Created by Raline Maria da Silva on 21/11/22.
//

import Foundation

struct MovieResults: Codable {
    let results: [MovieData]
}

struct MovieData: Codable {
    let id: String
    let title: String
    let releaseData: String
    let image: String?
    let overview: String
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseData = "release_date"
        case image = "poster_path"
        case overview
        case voteAverage = "vote_average"
    }
    
}
