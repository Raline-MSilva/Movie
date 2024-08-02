//
//  HomeInteractor.swift
//  Movie
//
//  Created by Raline Maria da Silva on 03/07/24.
//

import Combine
import Foundation

class HomeInteractor: HomeInteractorInputProtocol {
    
    internal weak var homePresenterInteractor: HomeInteractorOutputProtocol?
    internal var apiClient: APIClientProtocol?
    
    private var cancellables = Set<AnyCancellable>()
    
    func fetchNowPlayingTrailers() {
        apiClient?.fetchNowPlayingMovies { [weak self] result in
            guard let self = self else { return } // Capture strong self
            switch result {
            case .success(let movies):
                let trailersPublishers = movies.map { movie in
                    self.apiClient?.fetchMovieTrailersPublisher(for: movie.id) ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                
                Publishers.MergeMany(trailersPublishers)
                    .collect()
                    .map { $0.flatMap { $0 } }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        guard let self = self else { return } // Capture strong self
                        if case let .failure(error) = completion {
                            self.homePresenterInteractor?.didFailToFetchTrailers(with: error)
                        }
                    }, receiveValue: { [weak self] trailers in
                        guard let self = self else { return } // Capture strong self
                        self.homePresenterInteractor?.didFetchNowPlayingTrailers(trailers)
                    })
                    .store(in: &self.cancellables)
                
            case .failure(let error):
                self.homePresenterInteractor?.didFailToFetchTrailers(with: error)
            }
        }
    }
    
    func fetchUpcomingTrailers() {
        apiClient?.fetchUpComingMovies { [weak self] result in
            guard let self = self else { return } // Capture strong self
            switch result {
            case .success(let movies):
                let trailersPublishers = movies.map { movie in
                    self.apiClient?.fetchMovieTrailersPublisher(for: movie.id) ?? Just([]).setFailureType(to: Error.self).eraseToAnyPublisher()
                }
                
                Publishers.MergeMany(trailersPublishers)
                    .collect()
                    .map { $0.flatMap { $0 } }
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { [weak self] completion in
                        guard let self = self else { return } // Capture strong self
                        if case let .failure(error) = completion {
                            self.homePresenterInteractor?.didFailToFetchTrailers(with: error)
                        }
                    }, receiveValue: { [weak self] trailers in
                        guard let self = self else { return } // Capture strong self
                        self.homePresenterInteractor?.didFetchUpcomingTrailers(trailers)
                    })
                    .store(in: &self.cancellables)
                
            case .failure(let error):
                self.homePresenterInteractor?.didFailToFetchTrailers(with: error)
            }
        }
    }
}
