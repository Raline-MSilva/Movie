//
//  UIView+Extension.swift
//  Movie
//
//  Created by Raline Maria da Silva on 20/01/23.
//

import UIKit

extension UIView {
    func setBackground() {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.lightBackground.cgColor, UIColor.darkBackground.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.addSublayer(gradient)
    }
}
