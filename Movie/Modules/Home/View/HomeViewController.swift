//
//  HomeViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class HomeViewController: UIViewController {
    
    internal var homePresenter: HomePresenterProtocol?
    private var homeView: HomeView?
    
    internal override func loadView() {
        homeView = HomeView()
        homeView?.delegate = self
        view = homeView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        navigationItem.backButtonTitle = "Voltar"
    }

}

extension HomeViewController: HomeViewDelegate {
    func didTapMenuButton(_ menuItem: String) {
        let viewController: UIViewController
        
        switch menuItem {
        case "Filmes":
            viewController = MovieRouter.createMovieModule()
//        case "Séries":
//            viewController = SeriesRouter.createModule()
//        case "Pessoas":
//            viewController = PeopleRouter.createModule()
        default:
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }

}
