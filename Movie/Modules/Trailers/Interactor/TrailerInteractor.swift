//
//  TrailerInteractor.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import Foundation

class TrailerInteractor: TrailerInteractorProtocol {
    weak var presenter: TrailerInteractorOutputProtocol?
    internal var apiClient: APIClientProtocol?
    
    func fetchNowPlayingMovieTrailers() {
        apiClient?.fetchNowPlayingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.fetchTrailers(for: movies)
            case .failure(let error):
                self?.presenter?.onError(error: error)
            }
        }
    }
    
    func fetchUpcomingMovieTrailers() {
        apiClient?.fetchUpComingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.fetchTrailers(for: movies)
            case .failure(let error):
                self?.presenter?.onError(error: error)
            }
        }
    }
    
    private func fetchTrailers(for movies: [MovieEntity]) {
        var trailers: [Trailer] = []
        let group = DispatchGroup()
        
        for movie in movies {
            group.enter()
            apiClient?.fetchMovieTrailers(for: movie.id) { result in
                switch result {
                case .success(let trailer):
                    trailers.append(contentsOf: trailer)
                case .failure(let error):
                    print("Failed to fetch trailer for movie \(movie.id): \(error)")
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.presenter?.didFetchTrailers(trailers)
        }
    }
}
