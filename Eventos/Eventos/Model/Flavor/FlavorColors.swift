//
//  FlavorColors.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import UIKit

struct FlavorColorsSchemes {
    
    let background = FlavorColors(color: UIColor(hexString: "#272727"), onColor: UIColor(hexString: "#BEBEBE"))
    let primary = FlavorColors(color: UIColor(hexString: "#3BABC1"), onColor: UIColor(hexString: "#FFFFFF"))
    let surface = FlavorColors(color: UIColor(hexString: "#717171"), onColor: UIColor(hexString: "#FFFFFF"))
}

struct FlavorColors {
    
    let color: UIColor
    let onColor: UIColor
}
