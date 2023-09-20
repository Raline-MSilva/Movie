//
//  MovieTableViewCell.swift
//  Movie
//
//  Created by Raline Maria da Silva on 20/11/22.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell, SetupViewCode {
    static let identifier = "MovieTableViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var moviePoster: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 18
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var textStackView: UIStackView = {
        let textStack = UIStackView()
        textStack.axis = .vertical
        textStack.distribution = .fillProportionally
        textStack.spacing = 8
        textStack.translatesAutoresizingMaskIntoConstraints = false
        return textStack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStack = UIStackView()
        mainStack.axis = .horizontal
        mainStack.distribution = .fillProportionally
        mainStack.spacing = 16
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupConfigure() {
        backgroundColor = .clear
    }
    
    func configureCell(movie: Movie) {
        titleLabel.text = movie.title
        releaseDateLabel.text = "Lançamento: \(movie.releaseDate.formatterDate())"
        guard let posterURL = movie.image else { return }
        moviePoster.configurePoster(posterURL)
    }
    
    func setupSubviews() {
        textStackView.addArrangedSubview(titleLabel)
        textStackView.addArrangedSubview(releaseDateLabel)
        mainStackView.addArrangedSubview(moviePoster)
        mainStackView.addArrangedSubview(textStackView)
        
        addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            mainStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24),
            mainStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            moviePoster.widthAnchor.constraint(equalToConstant: 90),
            moviePoster.heightAnchor.constraint(equalToConstant: 120),
        ])
    }
}
