//
//  Trailer.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import Foundation

struct VideoResults: Codable {
    let results: [Video]
}

struct Video: Codable {
    let name: String
    let key: String
    let type: String
}

struct Trailer {
    let name: String
    let videoURL: String
}
