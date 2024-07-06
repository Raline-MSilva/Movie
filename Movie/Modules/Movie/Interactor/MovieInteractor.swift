//
//  MovieInteractorInputProtocol.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Foundation

internal class MovieInteractor: MovieInteractorInputProtocol {
    
    internal weak var interactorOutput: MovieInteractorOutputProtocol?
    private let networkApiClient: APIClientProtocol = APIClient()
    var movies: [MovieEntity] = []
    
    func fetchListPopularMovies() {
        //aqui busca filmes
        networkApiClient.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                //aqui me retorna eles
                self.interactorOutput?.didFetchPopularMovies(movies)
            case .failure(let error):
                self.interactorOutput?.didFailWithError(error)
            }
        }
    }
    
    func fetchNowPlayingMovies() {
        networkApiClient.fetchNowPlayingMovies { result in
            switch result {
            case .success(let movies):
                self.interactorOutput?.didFetchNowPlayingMovies(movies)
            case .failure(let error):
                self.interactorOutput?.didFailWithError(error)
            }
        }
    }
    
    func fetchUpComingMovies() {
        networkApiClient.fetchUpComingMovies { result in
            switch result {
            case .success(let movies):
                self.interactorOutput?.didFetchUpComingMovies(movies)
            case .failure(let error):
                self.interactorOutput?.didFailWithError(error)
            }
        }
    }
}
