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
    func setupConfigure() {
        backgroundColor = .clear
        
        menuStackView.axis = .horizontal
        menuStackView.distribution = .fillEqually
        menuStackView.alignment = .center
        menuStackView.spacing = 20
        menuStackView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    func setupSubviews() {
        addSubview(menuStackView)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            menuStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            menuStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),

        ])
    }
}
