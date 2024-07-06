//
//  MoviePresenter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Foundation

class MoviePresenter: MoviePresenterProtocol {
    
    weak var movieView: MovieViewProtocol?
    var interactorInput: MovieInteractorInputProtocol?
    var movieRouter: MovieRouterProtocol?
    
    func didLoadListMovies() {
        interactorInput?.fetchListPopularMovies()
        interactorInput?.fetchNowPlayingMovies()
        interactorInput?.fetchUpComingMovies()
    }
    
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity) {
        if let movies = interactorInput?.movies {
            let movie = movies[indexPath.row]
            
            guard let movieView = movieView else { return }
            movieRouter?.navigateToListMovies(from: movieView, with: movie)
        }
    }

}

extension MoviePresenter: MovieInteractorOutputProtocol {
    func didFetchUpComingMovies(_ movies: [MovieEntity]) {
        movieView?.showUpComingMovies(movies)
    }
    
    func didFetchPopularMovies(_ movies: [MovieEntity]) {
        movieView?.showListPopularMovies(movies)
    }
    
    func didFetchNowPlayingMovies(_ movies: [MovieEntity]) {
        movieView?.showNowPlayingMovies(movies)
    }
    
    func didFailWithError(_ error: Error) {
        movieView?.showError(error)
    }
}
