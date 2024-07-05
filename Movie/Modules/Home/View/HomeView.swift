//
//  HomeView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal protocol HomeViewDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity)
}

class HomeView: UIView {
    weak var delegate: HomeViewDelegate?
    
    internal var popularMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    internal var nowPlayingMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    internal var upComingMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    private var sections: [String] = ["Populares", "Em cartaz", "Próximas Estreias"]
    
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            return self.createSectionLayout(sectionIndex: sectionIndex)
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func createSectionLayout(sectionIndex: Int) -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.3))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        
        return section
    }
}

// MARK: SetupViewCode

extension HomeView: SetupViewCode {
    func setupConfigure() {
        backgroundColor = .clear
        
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.identifier)
        homeCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
    }
    
    func setupSubviews() {
        addSubview(homeCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            homeCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

// MARK: UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return popularMovies.count
        case 1:
            return nowPlayingMovies.count
        case 2:
            return upComingMovies.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let section = indexPath.section
        let index = indexPath.item
        
        switch section {
        case 0:
            cell.configure(with: popularMovies[index])

        case 1:
            
            cell.configure(with: nowPlayingMovies[index])
            
        case 2:
            
            cell.configure(with: upComingMovies[index])
            
        default:
            break
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension HomeView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
            fatalError("Could not dequeue header")
        }
        
        header.titleLabel.text = sections[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let index = indexPath.item
        var selectedMovie: MovieEntity?
        
        switch section {
        case 0:
            selectedMovie = popularMovies[index]
        case 1:
            selectedMovie = nowPlayingMovies[index]
        case 2:
            selectedMovie = upComingMovies[index]
        default:
            break
        }
        guard let movie = selectedMovie else {
            return
        }
        
        delegate?.didSelectCell(at: indexPath, with: movie)
    }

}
