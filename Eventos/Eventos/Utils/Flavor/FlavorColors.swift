//
//  FlavorColors.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

extension Flavor {
    
    struct ColorScheme {
        
        let background = Color(color: UIColor(hexString: "#272727"), onColor: UIColor(hexString: "#BEBEBE"))
        let primary = Color(color: UIColor(hexString: "#3BABC1"), onColor: UIColor(hexString: "#FFFFFF"))
        let surface = Color(color: UIColor(hexString: "#717171"), onColor: UIColor(hexString: "#FFFFFF"))
    }

    struct Color {
        
        let color: UIColor
        let onColor: UIColor
    }
}
