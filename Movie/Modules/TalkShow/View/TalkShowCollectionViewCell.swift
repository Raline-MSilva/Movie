//
//  TalkShowCollectionViewCell.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import UIKit

class TalkShowCollectionViewCell: UICollectionViewCell {
    static let identifier = "TalkShowCollectionViewCell"
    
    private var imageView: UIImageView
    
    override init(frame: CGRect) {
        self.imageView = UIImageView()
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with talkShow: TalkShowEntity) {
        guard let posterURL = talkShow.image else { return }
        imageView.configurePoster(posterURL)
    }
}

extension TalkShowCollectionViewCell: SetupViewCode {
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
