//
//  Movie.swift
//  Movie
//
//  Created by Raline Maria da Silva on 19/11/22.
//

import UIKit

struct Movie {
    let id: Int
    var title: String
    var overview: String
    var releaseDate: String
    var image: String?
    var voteAverage: Double
}

let movies: [Movie] = [
    Movie(id: 1, title: "Órfã 2: A Origem", overview: "", releaseDate: "2022-07-27", image: nil, voteAverage: 7.2),
    Movie(id: 2, title: "Minions 2: A Origem de Gru", overview: "", releaseDate: "2022-06-29", image: nil, voteAverage: 7.8),
    Movie(id: 3, title: "Thor: Amor e Trovão", overview: "", releaseDate: "2022-07-27", image: nil, voteAverage: 6.8),
    Movie(id: 4, title: "Avatar", overview: "", releaseDate: "2009-12-18", image: nil, voteAverage: 8.8)
    
]
