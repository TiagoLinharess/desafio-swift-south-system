//
//  UIView+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

extension UIView {
    
    func roundedCorner(withRadius radius: CGFloat) {
        layer.cornerRadius = radius
    }
    
    func border(with color: UIColor, andWidth width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
