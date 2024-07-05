//
//  HomeInteractor.swift
//  Movie
//
//  Created by Raline Maria da Silva on 03/07/24.
//

import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    internal weak var homePresenterInteractor: HomeInteractorOutputProtocol?
    private let networkApiClient: APIClientProtocol = APIClient()
    var movies: [MovieEntity] = []
    
    func fetchListPopularMovies() {
        //aqui busca filmes
        networkApiClient.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                //aqui me retorna eles
                self.homePresenterInteractor?.didFetchPopularMovies(movies)
            case .failure(let error):
                self.homePresenterInteractor?.didFailWithError(error)
            }
        }
    }
    
    func fetchNowPlayingMovies() {
        networkApiClient.fetchNowPlayingMovies { result in
            switch result {
            case .success(let movies):
                self.homePresenterInteractor?.didFetchNowPlayingMovies(movies)
            case .failure(let error):
                self.homePresenterInteractor?.didFailWithError(error)
            }
        }
    }
    
    func fetchUpComingMovies() {
        networkApiClient.fetchUpComingMovies { result in
            switch result {
            case .success(let movies):
                self.homePresenterInteractor?.didFetchUpComingMovies(movies)
            case .failure(let error):
                self.homePresenterInteractor?.didFailWithError(error)
            }
        }
    }

}
