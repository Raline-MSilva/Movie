//
//  MovieRouter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class MovieRouter: MovieRouterProtocol {

    static func createMovieModule() -> UIViewController {
        let movieViewController = MovieViewController()
        let presenter: MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
        let interactor: MovieInteractorInputProtocol = MovieInteractor()
        let router: MovieRouterProtocol = MovieRouter()
        
        movieViewController.moviePresenter = presenter
        presenter.movieView = movieViewController
        presenter.interactorInput = interactor
        presenter.movieRouter = router
        interactor.interactorOutput = presenter
        
        return movieViewController
    }
    
    func navigateToListMovies(from view: MovieViewProtocol, with movie: MovieEntity) {
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
        
    }

}
