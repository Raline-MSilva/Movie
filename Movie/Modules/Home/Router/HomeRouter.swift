//
//  HomeRouter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 03/07/24.
//

import UIKit

class HomeRouter: HomeRouterProtocol {

    static func createHomeModule() -> UIViewController {
        let homeViewController = HomeViewController()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        let router: HomeRouterProtocol = HomeRouter()
        
        homeViewController.homePresenter = presenter
        presenter.homeView = homeViewController
        presenter.homeInteractor = interactor
        presenter.homeRouter = router
        interactor.homePresenterInteractor = presenter
        
        return homeViewController
    }
    
    func navigateToMovies(from view: HomeViewProtocol, with movie: MovieEntity) {
        let movieDetailsVC = MovieDetailsViewController(movie: movie)
        if let viewController = view as? UIViewController {
            viewController.navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
        
    }

}
