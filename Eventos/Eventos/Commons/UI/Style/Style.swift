//
//  Style.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import UIKit

enum Style {
    
    case primary, surface, background
    
    private var scheme: Flavor.Color {
        let colors = Flavor.shared.colors
        
        switch self {
        case .primary:
            return colors.primary
        case .surface:
            return colors.surface
        case .background:
            return colors.background
        }
    }
    
    var color: UIColor {  scheme.color }
    
    var onColor: UIColor { scheme.onColor }
}
