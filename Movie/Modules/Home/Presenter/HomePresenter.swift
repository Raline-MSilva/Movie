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
    
    func didLoadListMovies() {
        homeInteractor?.fetchListPopularMovies()
        homeInteractor?.fetchNowPlayingMovies()
        homeInteractor?.fetchUpComingMovies()
    }
    
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity) {
        if let movies = homeInteractor?.movies {
            let movie = movies[indexPath.row]
            
            guard let movieView = homeView else { return }
            homeRouter?.navigateToMovies(from: movieView, with: movie)
        }
    }

}

extension HomePresenter: HomeInteractorOutputProtocol {
    func didFetchUpComingMovies(_ movies: [MovieEntity]) {
        homeView?.showUpComingMovies(movies)
    }
    
    func didFetchPopularMovies(_ movies: [MovieEntity]) {
        homeView?.showListPopularMovies(movies)
    }
    
    func didFetchNowPlayingMovies(_ movies: [MovieEntity]) {
        homeView?.showNowPlayingMovies(movies)
    }
    
    func didFailWithError(_ error: Error) {
        homeView?.showError(error)
    }
    
}
