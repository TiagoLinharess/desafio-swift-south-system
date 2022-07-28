//
//  UIColor+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

extension UIColor {
    
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let chars = Array(hexString.dropFirst())
        self.init(red:   .init(strtoul(String(chars[0...1]),nil,16))/255,
                  green: .init(strtoul(String(chars[2...3]),nil,16))/255,
                  blue:  .init(strtoul(String(chars[4...5]),nil,16))/255,
                  alpha: alpha)
        
    }
}
