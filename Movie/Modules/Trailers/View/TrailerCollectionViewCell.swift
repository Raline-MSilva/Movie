//
//  TrailerCollectionViewCell.swift
//  Movie
//
//  Created by Raline Maria da Silva on 22/07/24.
//

import UIKit
import AVKit

class TrailerCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrailerCollectionViewCell"
    private var playerLayer: AVPlayerLayer?
    private var player: AVPlayer?
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.textAlignment = .center
        titleLabel.backgroundColor = .black.withAlphaComponent(0.5)
        titleLabel.textColor = .white
    }
    
    func configure(with trailer: Trailer) {
        // Remove any existing player layer
        playerLayer?.removeFromSuperlayer()
        player = nil
        
        // Configure the cell with trailer data
        titleLabel.text = trailer.name
        
        // Create and configure the AVPlayer with the trailer URL
        if let url = URL(string: trailer.videoURL) {
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.frame = contentView.bounds
            playerLayer?.videoGravity = .resizeAspectFill
            if let playerLayer = playerLayer {
                contentView.layer.insertSublayer(playerLayer, below: titleLabel.layer)
            }
            player?.play()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playerLayer?.removeFromSuperlayer()
        player = nil
    }
}
