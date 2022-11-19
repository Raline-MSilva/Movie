//
//  SetupViewCode.swift
//  Movie
//
//  Created by Raline Maria da Silva on 19/11/22.
//

import Foundation

protocol SetupViewCode {
    func setupSubviews()
    func setupConstraints()
    func setup()
}

extension SetupViewCode {
    func setup() {
        setupSubviews()
        setupConstraints()
    }
}
