//
//  MovieProtocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal protocol MovieViewProtocol: AnyObject {
    var moviePresenter: MoviePresenterProtocol? { get set }
    func showPopularMovies(_ movies: [MovieEntity])
    func showError(_ error: Error)
}

internal protocol MoviePresenterProtocol: AnyObject {
    var movieView: MovieViewProtocol? { get set }
    var interactor: MovieInteractorInputProtocol? { get set }
    var router: MovieRouterProtocol? { get set }
    func didLoadMovies()
    func didSelectCell(at indexPath: IndexPath)
}

internal protocol MovieInteractorInputProtocol: AnyObject {
    var presenter: MovieInteractorOutputProtocol? { get set }
    var apiClient: APIClientProtocol { get set }
    var movies: [MovieEntity] { get set }
    func fetchMovies()
}

internal protocol MovieInteractorOutputProtocol: AnyObject {
    func didFetchMovies(_ movies: [MovieEntity])
    func didFailWithError(_ error: Error)
}

internal protocol MovieRouterProtocol: AnyObject {
    static func createMovieModule() -> UIViewController
    func navigateToMovieDetails(from view: MovieViewProtocol, with movie: MovieEntity)
}
