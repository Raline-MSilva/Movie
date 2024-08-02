//
//  HomeView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal protocol HomeViewDelegate: AnyObject {
    func didTapMenuButton(_ menuItem: String)
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    private var menuStackView: UIStackView
    private lazy var nowPlayingCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            return NSCollectionLayoutSection.createSectionLayout(sectionIndex: sectionIndex)
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private lazy var upcomingCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            return NSCollectionLayoutSection.createSectionLayout(sectionIndex: sectionIndex)
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    internal var nowPlayingTrailers: [Trailer] = [] {
        didSet {
            print("HomeView: nowPlayingTrailers updated with \(nowPlayingTrailers.count) trailers")
            nowPlayingCollectionView.reloadData()
        }
    }
    
    internal var upcomingTrailers: [Trailer] = [] {
        didSet {
            print("HomeView: upPlayingTrailers updated with \(upcomingTrailers.count) trailers")
            upcomingCollectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        self.menuStackView = UIStackView()
        super.init(frame: frame)
        setup()
        setupMenuButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMenuButtons() {
        let menuItems = ["Filmes", "Séries", "Pessoas", "Mais"]
        
        for item in menuItems {
            let button = UIButton(type: .system)
            button.setTitle(item, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
            button.backgroundColor = .darkGray
            button.layer.cornerRadius = 8
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
            menuStackView.addArrangedSubview(button)
        }
    }

    @objc private func menuButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        delegate?.didTapMenuButton(title)
    }

}

// MARK: SetupViewCode

extension HomeView: SetupViewCode {
    func setupSubviews() {
        addSubview(menuStackView)
        addSubview(nowPlayingCollectionView)
        addSubview(upcomingCollectionView)
    }
    
    func setupConfigure() {
        backgroundColor = .clear
        nowPlayingCollectionView.backgroundColor = .blue
        upcomingCollectionView.backgroundColor = .brown
        menuStackView.backgroundColor = .red
        
        menuStackView.axis = .horizontal
        menuStackView.distribution = .fillEqually
        menuStackView.alignment = .center
        menuStackView.spacing = 20
        menuStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 300, height: 200)
        layout.minimumLineSpacing = 20
        
        nowPlayingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        nowPlayingCollectionView.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.identifier)
        nowPlayingCollectionView.dataSource = self
        nowPlayingCollectionView.delegate = self
        nowPlayingCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        upcomingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        upcomingCollectionView.register(TrailerCollectionViewCell.self, forCellWithReuseIdentifier: TrailerCollectionViewCell.identifier)
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        upcomingCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            menuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            nowPlayingCollectionView.topAnchor.constraint(equalTo: menuStackView.bottomAnchor, constant: 20),
            nowPlayingCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nowPlayingCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            nowPlayingCollectionView.heightAnchor.constraint(equalToConstant: 200),
            
            upcomingCollectionView.topAnchor.constraint(equalTo: nowPlayingCollectionView.bottomAnchor, constant: 20),
            upcomingCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            upcomingCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            upcomingCollectionView.heightAnchor.constraint(equalToConstant: 200)
            
        ])
        
    }
}

extension HomeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == nowPlayingCollectionView {
            return nowPlayingTrailers.count
        } else {
            return upcomingTrailers.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrailerCollectionViewCell", for: indexPath) as! TrailerCollectionViewCell
        let trailer: Trailer
        
        if collectionView == nowPlayingCollectionView {
            trailer = nowPlayingTrailers[indexPath.item]
        } else {
            trailer = upcomingTrailers[indexPath.item]
        }
        
        cell.configure(with: trailer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 200)
    }
}
