//
//  Protocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    var homePresenter: HomePresenterProtocol? { get set }
    func showListPopularMovies(_ movies: [MovieEntity])
    func showNowPlayingMovies(_ movies: [MovieEntity])
    func showUpComingMovies(_ movies: [MovieEntity])
    func showError(_ error: Error)
}

protocol HomePresenterProtocol: AnyObject {
    var homeView: HomeViewProtocol? { get set }
    var homeInteractor: HomeInteractorInputProtocol? { get set }
    var homeRouter: HomeRouterProtocol? { get set }
    func didLoadListMovies()
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity)
}

protocol HomeInteractorInputProtocol: AnyObject {
    var homePresenterInteractor: HomeInteractorOutputProtocol? { get set }
    var movies: [MovieEntity] { get set }
    func fetchListPopularMovies()
    func fetchNowPlayingMovies()
    func fetchUpComingMovies()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func didFetchPopularMovies(_ movies: [MovieEntity])
    func didFetchNowPlayingMovies(_ movies: [MovieEntity])
    func didFetchUpComingMovies(_ movies: [MovieEntity])
    func didFailWithError(_ error: Error)
}

protocol HomeRouterProtocol: AnyObject {
    static func createHomeModule() -> UIViewController
    func navigateToMovies(from view: HomeViewProtocol, with movie: MovieEntity)
}
