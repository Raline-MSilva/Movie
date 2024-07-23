//
//  TalkShowView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 08/07/24.
//

import UIKit

class TalkShowView: UIView {
    
    internal var popularTalkShow: [TalkShowEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.talkShowCollectionView.reloadData()
            }
        }
    }
    
    internal var airingTodayTalkShow: [TalkShowEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.talkShowCollectionView.reloadData()
            }
        }
    }
    
    internal var onTheAirTalkShow: [TalkShowEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.talkShowCollectionView.reloadData()
            }
        }
    }
    
    private var sections: [String] = ["Populares", "Em exibição", "Na TV"]
    
    private lazy var talkShowCollectionView: UICollectionView = {
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

extension TalkShowView: SetupViewCode {
    func setupConfigure() {
        backgroundColor = .clear
        
        talkShowCollectionView.translatesAutoresizingMaskIntoConstraints = false
        talkShowCollectionView.delegate = self
        talkShowCollectionView.dataSource = self
        
        talkShowCollectionView.register(TalkShowCollectionViewCell.self, forCellWithReuseIdentifier: TalkShowCollectionViewCell.identifier)
        talkShowCollectionView.register(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderView.identifier)
        
    }
    
    func setupSubviews() {
        addSubview(talkShowCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            talkShowCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            talkShowCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            talkShowCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            talkShowCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}

//MARK: UICollectionViewDataSource

extension TalkShowView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return popularTalkShow.count
        case 1:
            return airingTodayTalkShow.count
        case 2:
            return onTheAirTalkShow.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TalkShowCollectionViewCell.identifier, for: indexPath) as? TalkShowCollectionViewCell else {
            fatalError("Could not dequeue cell")
        }
        
        let section = indexPath.section
        let index = indexPath.item
        
        switch section {
        case 0:
            cell.configure(with: popularTalkShow[index])
            
        case 1:
            cell.configure(with: airingTodayTalkShow[index])
            
        case 2:
            cell.configure(with: onTheAirTalkShow[index])
            
        default:
            break
        }
        return cell
    }
}

// MARK: UICollectionViewDelegate

extension TalkShowView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderView.identifier, for: indexPath) as? SectionHeaderView else {
            fatalError("Could not dequeue header")
        }
        
        header.titleLabel.text = sections[indexPath.section]
        return header
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        
//        let section = indexPath.section
//        let index = indexPath.item
//        var selectedMovie: MovieEntity?
//        
//        switch section {
//        case 0:
//            selectedMovie = popularMovies[index]
//        case 1:
//            selectedMovie = nowPlayingMovies[index]
//        case 2:
//            selectedMovie = upComingMovies[index]
//        default:
//            break
//        }
//        guard let movie = selectedMovie else {
//            return
//        }
//        ///delegate?.didSelectCell(at: indexPath, with: movie)
//    }
    
}

