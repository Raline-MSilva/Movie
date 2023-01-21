//
//  ViewController.swift
//  Movie
//
//  Created by Raline Maria da Silva on 19/11/22.
//

import UIKit

class PageHomeViewController: UIViewController, SetupViewCode {
    
    private var requestNetwork = Network()
    private var movies: [Movie] = [] {
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
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "movieCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.setBackground()
        setup()
        getPopularMovies()
    }
    
    func getPopularMovies() {
        requestNetwork.fetchPopularMovies { movies in
            self.movies = movies
        }
    }
    
    func setupConfigure() {
        navigationItem.backButtonTitle = " Voltar "
    }

    func setupSubviews() {
        view.addSubview(titleView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 24),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PageHomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? MovieTableViewCell else {
            fatalError("erro ao carregar a celula")
        }
        cell.configureCell(movie: movies[indexPath.row])
        return cell
    }
}

extension PageHomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controllerDetails = MovieDetailsViewController(movie: movies[indexPath.row])
        navigationController?.pushViewController(controllerDetails, animated: true)
    }
}
