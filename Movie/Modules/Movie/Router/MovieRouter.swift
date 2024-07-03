//
//  MovieRouter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class MovieRouter: MovieRouterProtocol {

    internal static func createMovieModule() -> UIViewController {
        let viewController = MovieViewController()
        let presenter: MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
        let interactor: MovieInteractorInputProtocol = MovieInteractor()
        let router: MovieRouterProtocol = MovieRouter()

        viewController.moviePresenter = presenter
        presenter.movieView = viewController
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter

        return viewController
    }
    
    internal func navigateToMovieDetails(from view: MovieViewProtocol, with movie: MovieEntity) {
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
    }

}
