//
//  MovieDetailsView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 16/07/23.
//

import UIKit

final class MovieDetailsView: UIView {
    
    private let movie: Movie
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = movie.title
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        return label
    }()
    
    private lazy var userRating: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avaliação dos Usuários: \(movie.voteAverage)"
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 16.0, weight: .bold)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .white.withAlphaComponent(0.75)
        label.attributedText = NSAttributedString(string: movie.overview).withLineSpacing(7.0)
        return label
    }()
    
    internal lazy var imagePoster: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 32.0
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    init(movie: Movie) {
        self.movie = movie
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetupViewCode

extension MovieDetailsView: SetupViewCode {
    func setupConfigure() {
        setBackground()
        
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(imagePoster)
        addSubview(userRating)
        addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32.0),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            
            userRating.topAnchor.constraint(equalTo: imagePoster.bottomAnchor, constant: 32.0),
            userRating.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            imagePoster.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imagePoster.widthAnchor.constraint(equalToConstant: 192.0),
            imagePoster.heightAnchor.constraint(equalToConstant: 264.0),
            imagePoster.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32.0),
            
            descriptionLabel.topAnchor.constraint(equalTo: userRating.bottomAnchor, constant: 32.0),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
        ])
    }
}
