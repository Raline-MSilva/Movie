//
//  MovieInteractorInputProtocol.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Foundation

internal class MovieInteractor: MovieInteractorInputProtocol {
    
    internal weak var presenter: MovieInteractorOutputProtocol?
    internal var apiClient: APIClientProtocol = APIClient()
    internal var movies: [MovieEntity] = []

    internal func fetchMovies() {
        apiClient.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.presenter?.didFetchMovies(movies)
            case .failure(let error):
                self.presenter?.didFailWithError(error)
            }
        }
    }
}
