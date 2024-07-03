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
        moviePresenter?.didLoadMovies()
        view.backgroundColor = .lightGray
    }

    internal func showPopularMovies(_ movies: [MovieEntity]) {
        movieView?.movies = movies
    }

    internal func showError(_ error: Error) {
        print("Erro: \(error.localizedDescription)")
    }
}

extension MovieViewController: MovieViewDelegate {

    internal func didSelectCell(at indexPath: IndexPath) {
        moviePresenter?.didSelectCell(at: indexPath)
    }
}
