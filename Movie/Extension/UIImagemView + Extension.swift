//
//  UIImagemView + Extension.swift
//  Movie
//
//  Created by Raline Maria da Silva on 17/01/23.
//

import Foundation
import Kingfisher

extension UIImageView {
    func configurePoster(_ posterURL: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterURL)")
        self.kf.setImage(with: url)
    }
}
