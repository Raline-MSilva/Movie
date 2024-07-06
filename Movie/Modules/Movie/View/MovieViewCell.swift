//
//  MovieViewCell.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

class MovieViewCell: UICollectionViewCell {
    static let identifier = "MovieViewCell"
    
    private var imageView: UIImageView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with movie: MovieEntity) {
        guard let posterURL = movie.image else { return }
        imageView.configurePoster(posterURL)
    }
}

extension MovieViewCell: SetupViewCode {
    func setupSubviews() {
        contentView.addSubview(imageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
    
    func setupConfigure() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
}
