//
//  ViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 19/11/22.
//

import UIKit

class PageHomeViewController: UIViewController {
    
    private var requestNetwork: Network
    private var pageHomeView: PageHomeView?
    private var movie: Movie?
    
    init(requestNetwork: Network) {
        self.requestNetwork = requestNetwork
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        pageHomeView = PageHomeView()
        pageHomeView?.delegate = self
        view = pageHomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPopularMovies()
        navigationItem.backButtonTitle = " Voltar "
    }
    
    func getPopularMovies() {
        requestNetwork.fetchPopularMovies { movies in
            self.pageHomeView?.movies = movies
        }
    }
}
extension PageHomeViewController: TableViewDelegate {
    func didSelectCell(at indePath: IndexPath) {
        guard let selectedMovie = pageHomeView?.movies[indePath.row] else { return }
        let nextViewController = MovieDetailsViewController(movie: selectedMovie)
        navigationController?.pushViewController(nextViewController, animated: false)
    }
}
