//
//  TrailersProtocols.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import UIKit

protocol TrailerInteractorProtocol: AnyObject {
    var presenter: TrailerInteractorOutputProtocol? { get set }
    var apiClient: APIClientProtocol? { get set }
    
    func fetchNowPlayingMovieTrailers()
    func fetchUpcomingMovieTrailers()
}

protocol TrailerInteractorOutputProtocol: AnyObject {
    func didFetchTrailers(_ trailers: [Trailer])
    func onError(error: Error)
}

protocol TrailerPresenterProtocol: AnyObject {
    func didLoadTrailers()
}

protocol TrailerViewProtocol: AnyObject {
    func showNowPlayingTrailers(_ trailers: [Trailer])
    func showUpcomingTrailers(_ trailers: [Trailer])
    func showError(_ message: String)
}

protocol TrailerRouterProtocol: AnyObject {
    static func createTrailerModule() -> UIViewController
}
