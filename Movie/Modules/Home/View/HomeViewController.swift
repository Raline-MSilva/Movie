//
//  HomeViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal class HomeViewController: UIViewController {
    
    internal var homePresenter: HomePresenterProtocol?
    internal var homeView: HomeView?
    
    internal override func loadView() {
        homeView = HomeView()
        homeView?.delegate = self
        view = homeView
    }
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        // Log to ensure viewDidLoad is called
        print("HomeViewController: viewDidLoad called")
        
        // Ensure the presenter is not nil before calling methods on it
        guard let presenter = homePresenter else {
            print("HomeViewController: homePresenter is nil")
            return
        }
        homePresenter?.loadNowPlayingTrailers()
        homePresenter?.loadUpcomingTrailers()
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
        case "Séries":
            viewController = TalkShowRouter.createTalkShowModule()
            //        case "Pessoas":
            //            viewController = PeopleRouter.createModule()
        default:
            return
        }
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

extension HomeViewController: HomeViewProtocol {
    func showNowPlayingTrailers(_ trailers: [Trailer]) {
        print("HomeViewController: showNowPlayingTrailers called with \(trailers.count) trailers")
        homeView?.nowPlayingTrailers = trailers
    }
    
    func showUpcomingTrailers(_ trailers: [Trailer]) {
        print("HomeViewController: showUpcomingTrailers called with \(trailers.count) trailers")
        homeView?.upcomingTrailers = trailers
    }
    
    func showError(_ error: Error) {
        print("HomeViewController: showError called with error: \(error)")
    }
}
