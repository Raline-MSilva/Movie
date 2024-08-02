//
//  TrailerRouter.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import UIKit

class TrailerRouter: TrailerRouterProtocol {
    static func createTrailerModule() -> UIViewController {
        let homeViewController = HomeViewController()
        let homeInteractor = TrailerInteractor()
        let router = TrailerRouter()
//        MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
        //let presenter = TrailerPresenterProtocol & TrailerInteractorOutputProtocol = TrailerPresenter()
        //let presenter = TrailerPresenter(trailerView: homeView, trailerInteractor: homeInteractor, trailerRouter: router)
        
        //homeViewController.homePresenter = presenter
        //homeInteractor.presenter = presenter
        
        return homeViewController
    }
}
