//
//  Protocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

protocol HomeViewProtocol: AnyObject {
    func showNowPlayingTrailers(_ trailers: [Trailer])
    func showUpcomingTrailers(_ trailers: [Trailer])
    func showError(_ error: Error)
}

protocol HomePresenterProtocol: AnyObject {
    var homeView: HomeViewProtocol? { get set }
    var homeInteractor: HomeInteractorInputProtocol? { get set }
    var homeRouter: HomeRouterProtocol? { get set }
    func loadNowPlayingTrailers()
    func loadUpcomingTrailers()
}

protocol HomeInteractorInputProtocol: AnyObject {
    var homePresenterInteractor: HomeInteractorOutputProtocol? { get set }
    var apiClient: APIClientProtocol? { get set }
    func fetchNowPlayingTrailers()
    func fetchUpcomingTrailers()
}

protocol HomeInteractorOutputProtocol: AnyObject {
    func didFetchNowPlayingTrailers(_ trailers: [Trailer])
    func didFetchUpcomingTrailers(_ trailers: [Trailer])
    func didFailToFetchTrailers(with error: Error)
}

protocol HomeRouterProtocol: AnyObject {
    static func createHomeModule() -> UIViewController
    //func navigateToMovies(from view: HomeViewProtocol, with movie: Trailer)
}
