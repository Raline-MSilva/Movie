//
//  MovieView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 02/07/24.
//

import UIKit

protocol MovieViewDelegate: AnyObject {
    func didSelectCell(at indePath: IndexPath)
}

class MovieView: UIView {
    weak var delegate: MovieViewDelegate?
    internal var movies: [MovieEntity] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    private lazy var titleView: UILabel = {
        let label = UILabel()
        label.text = "Filmes Populares"
        label.font = .systemFont(ofSize: 28.0, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MovieViewCell.self, forCellReuseIdentifier: MovieViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        
    }

    func setupSubviews() {
        addSubview(titleView)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: UITableViewDataSource

extension MovieView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
            fatalError("erro ao carregar a celula")
        }
        cell.configureCell(movie: movies[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension MovieView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.didSelectCell(at: indexPath)
    }
}
