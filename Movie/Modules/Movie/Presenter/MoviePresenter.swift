//
//  MoviePresenter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 01/07/24.
//

import Foundation

class MoviePresenter: MoviePresenterProtocol {
    
    internal weak var movieView: MovieViewProtocol?
    internal var interactor: MovieInteractorInputProtocol?
    internal var router: MovieRouterProtocol?

    internal func didLoadMovies() {
        interactor?.fetchMovies()
    }

    internal func didSelectCell(at indexPath: IndexPath) {
        if let movies = interactor?.movies {
            let movie = movies[indexPath.row]
            
            guard let movieView = movieView else { return }
            router?.navigateToMovieDetails(from: movieView, with: movie)
        }
    }
}

extension MoviePresenter: MovieInteractorOutputProtocol {
    internal func didFetchMovies(_ movies: [MovieEntity]) {
        movieView?.showPopularMovies(movies)
    }

    internal func didFailWithError(_ error: Error) {
        movieView?.showError(error)
    }

}
