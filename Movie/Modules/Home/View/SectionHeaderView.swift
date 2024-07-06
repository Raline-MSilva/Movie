//
//  SectionHeaderView.swift
//  Movie
//
//  Created by Raline Maria da Silva on 03/07/24.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    static let identifier = "SectionHeaderView"

    internal let titleLabel: UILabel

    override init(frame: CGRect) {
        self.titleLabel = UILabel()
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SectionHeaderView: SetupViewCode {
    func setupSubviews() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func setupConfigure() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
    }
    
    
}
