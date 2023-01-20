//
//  Movie.swift
//  Movie
//
//  Created by Raline Maria da Silva on 19/11/22.
//

import UIKit

struct MovieResults: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let image: String?
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case image = "poster_path"
        case voteAverage = "vote_average"
    }
}
