//
//  MovieView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

internal protocol MovieViewDelegate: AnyObject {
    func didSelectCell(at indexPath: IndexPath, with movie: MovieEntity)
}

class MovieView: UIView {
    weak var delegate: MovieViewDelegate?
    
    internal var popularMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }

    internal var nowPlayingMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }

    internal var upComingMovies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        }
    }
    
    private var sections: [String] = ["Populares", "Em cartaz", "Próximas Estreias"]
    
    private lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            return NSCollectionLayoutSection.createSectionLayout(sectionIndex: sectionIndex)
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

}

// MARK: SetupViewCode

extension MovieView: SetupViewCode {
    func setupConfigure() {
        backgroundColor = .clear
        
        movieCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self

        movieCollectionView.register(MovieViewCell.self, forCellWithReuseIdentifier: MovieViewCell.identifier)
        movieCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)

    }
    
    func setupSubviews() {
        addSubview(movieCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            movieCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            movieCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            movieCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

 //MARK: UICollectionViewDataSource

extension MovieView: UICollectionViewDataSource {

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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
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

extension MovieView: UICollectionViewDelegate {

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
