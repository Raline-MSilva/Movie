//
//  TrailerPresenter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import Foundation

class TrailerPresenter: TrailerPresenterProtocol {
    
    weak var trailerView: TrailerViewProtocol?
    var trailerInteractor: TrailerInteractorProtocol?
    var trailerRouter: TrailerRouterProtocol?

    init(trailerView: TrailerViewProtocol, trailerInteractor: TrailerInteractorProtocol, trailerRouter: TrailerRouterProtocol) {
        self.trailerView = trailerView
        self.trailerInteractor = trailerInteractor
        self.trailerRouter = trailerRouter
    }

    func didLoadTrailers() {
        trailerInteractor?.fetchNowPlayingMovieTrailers()
        trailerInteractor?.fetchUpcomingMovieTrailers()
    }
}

extension TrailerPresenter: TrailerInteractorOutputProtocol {
    func didFetchTrailers(_ trailers: [Trailer]) {
        trailerView?.showNowPlayingTrailers(trailers)
        trailerView?.showUpcomingTrailers(trailers)
    }
    
    func onError(error: Error) {
        trailerView?.showError(error.localizedDescription)
    }

}
