//
//  MovieViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class MovieViewController: UIViewController, MovieViewProtocol {

    internal var moviePresenter: MoviePresenterProtocol?
    private var movieView: MovieView?
    
    internal override func loadView() {
        movieView = MovieView()
        movieView?.delegate = self
        view = movieView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        moviePresenter?.didLoadListMovies()
        navigationItem.backButtonTitle = "Voltar"
    }

    internal func showListPopularMovies(_ movies: [MovieEntity]) {
        movieView?.popularMovies = movies
    }
    
    internal func showNowPlayingMovies(_ movies: [MovieEntity]) {
        movieView?.nowPlayingMovies = movies
    }
    
    internal func showUpComingMovies(_ movies: [MovieEntity]) {
        movieView?.upComingMovies = movies
    }

    internal func showError(_ error: Error) {
        print("Erro: \(error.localizedDescription)")
    }
}

extension MovieViewController: MovieViewDelegate {
    internal func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity) {
        moviePresenter?.didSelectCell(at: indexPath, with: movie)
    }
}
