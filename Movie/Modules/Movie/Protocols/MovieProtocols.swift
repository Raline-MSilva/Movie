//
//  MovieProtocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

protocol MovieViewProtocol: AnyObject {
    var moviePresenter: MoviePresenterProtocol? { get set }
    func showListPopularMovies(_ movies: [MovieEntity])
    func showNowPlayingMovies(_ movies: [MovieEntity])
    func showUpComingMovies(_ movies: [MovieEntity])
    func showError(_ error: Error)
}

protocol MoviePresenterProtocol: AnyObject {
    var movieView: MovieViewProtocol? { get set }
    var interactorInput: MovieInteractorInputProtocol? { get set }
    var movieRouter: MovieRouterProtocol? { get set }
    func didLoadListMovies()
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity)
}

protocol MovieInteractorInputProtocol: AnyObject {
    var interactorOutput: MovieInteractorOutputProtocol? { get set }
    var movies: [MovieEntity] { get set }
    func fetchListPopularMovies()
    func fetchNowPlayingMovies()
    func fetchUpComingMovies()
}

protocol MovieInteractorOutputProtocol: AnyObject {
    func didFetchPopularMovies(_ movies: [MovieEntity])
    func didFetchNowPlayingMovies(_ movies: [MovieEntity])
    func didFetchUpComingMovies(_ movies: [MovieEntity])
    func didFailWithError(_ error: Error)
}

protocol MovieRouterProtocol: AnyObject {
    static func createMovieModule() -> UIViewController
    func navigateToListMovies(from view: MovieViewProtocol, with movie: MovieEntity)
}
