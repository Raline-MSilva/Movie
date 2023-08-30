//
//  PageHomeView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 14/07/23.
//

import UIKit

protocol TableViewDelegate: AnyObject {
    func didSelectCell(at indePath: IndexPath)
}

final class PageHomeView: UIView {
    weak var delegate: TableViewDelegate?
    internal var movies: [Movie] = [] {
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
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //setBackground()
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: SetupViewCode

extension PageHomeView: SetupViewCode {
    func setupConfigure() {
        //backgroundColor = .blue
        self.setBackground()
        
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

extension PageHomeView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            fatalError("erro ao carregar a celula")
        }
        cell.configureCell(movie: movies[indexPath.row])
        return cell
    }
}

// MARK: UITableViewDelegate

extension PageHomeView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.didSelectCell(at: indexPath)
    }
}
