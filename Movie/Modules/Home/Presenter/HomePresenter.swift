//
//  HomePresenter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 03/07/24.
//

import Foundation

class HomePresenter: HomePresenterProtocol {
    
    weak var homeView: HomeViewProtocol?
    var homeInteractor: HomeInteractorInputProtocol?
    var homeRouter: HomeRouterProtocol?
    var apiClient: APIClientProtocol?
    
//    init(homeView: HomeViewProtocol, apiClient: APIClientProtocol) {
//        self.homeView = homeView
//        self.apiClient = apiClient
//    }
    
    func loadNowPlayingTrailers() {
        homeInteractor?.fetchNowPlayingTrailers()
    }
    
    func loadUpcomingTrailers() {
        homeInteractor?.fetchUpcomingTrailers()
    }
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func didFetchNowPlayingTrailers(_ trailers: [Trailer]) {
        homeView?.showNowPlayingTrailers(trailers)
    }
    
    func didFetchUpcomingTrailers(_ trailers: [Trailer]) {
        homeView?.showUpcomingTrailers(trailers)
    }
    
    func didFailToFetchTrailers(with error: Error) {
        homeView?.showError(error.localizedDescription as! Error)
    }

}
