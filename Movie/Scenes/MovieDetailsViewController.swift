//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 27/11/22.
//

import UIKit
import Kingfisher

class MovieDetailsViewController: UIViewController {
    
    private var movie: Movie
    private var movieDetail: MovieDetailsView?
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        movieDetail = MovieDetailsView(movie: movie)
        view = movieDetail
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageURL = movie.image else { return }
        movieDetail?.imagePoster.configurePoster(imageURL)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
