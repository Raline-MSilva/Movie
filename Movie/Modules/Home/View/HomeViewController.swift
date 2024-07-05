//
//  HomeViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class HomeViewController: UIViewController, HomeViewProtocol {
    
    internal var homePresenter: HomePresenterProtocol?
    private var homeView: HomeView?

    internal override func loadView() {
        homeView = HomeView()
        homeView?.delegate = self
        view = homeView
    }

    internal override func viewDidLoad() {
        super.viewDidLoad()
        homePresenter?.didLoadListMovies()
        view.backgroundColor = .lightGray
        navigationItem.backButtonTitle = " Voltar "
    }

    internal func showListPopularMovies(_ movies: [MovieEntity]) {
        homeView?.popularMovies = movies
    }
    
    internal func showNowPlayingMovies(_ movies: [MovieEntity]) {
        homeView?.nowPlayingMovies = movies
    }
    
    internal func showUpComingMovies(_ movies: [MovieEntity]) {
        homeView?.upComingMovies = movies
    }

    internal func showError(_ error: Error) {
        print("Erro: \(error.localizedDescription)")
    }
}

extension HomeViewController: HomeViewDelegate {
    internal func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity) {
        homePresenter?.didSelectCell(at: indexPath, with: movie)
    }

}
