//
//  TalkShowEntity.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import Foundation

internal struct TalkShowEntityResults: Codable {
    let results: [TalkShowEntity]
}

internal struct TalkShowEntity: Codable {
    let id: Int
    let name: String
    let overview: String
    let firstDate: String
    let image: String?
    let voteAverage: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case overview
        case firstDate = "first_air_date"
        case image = "poster_path"
        case voteAverage = "vote_average"
    }
}
