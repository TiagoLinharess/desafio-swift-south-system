//
//  FlavorFonts.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import UIKit

extension Flavor {
    
    struct Font {
        
        let quickSandLight: UIFont
        let quickSandRegular: UIFont
        let quickSandMedium: UIFont
        let quickSandSemiBold: UIFont
        let quickSandBold: UIFont
        
        init() {
            guard let quickSandLight = UIFont(name: "Quicksand-Light", size: 16),
                  let quickSandRegular = UIFont(name: "Quicksand-Regular", size: 16),
                  let quickSandMedium = UIFont(name: "Quicksand-Medium", size: 16),
                  let quickSandSemiBold = UIFont(name: "Quicksand-SemiBold", size: 16),
                  let quickSandBold = UIFont(name: "Quicksand-Bold", size: 16)
            else {
                fatalError("font not found")
            }
            
            self.quickSandLight = quickSandLight
            self.quickSandRegular = quickSandRegular
            self.quickSandMedium = quickSandMedium
            self.quickSandSemiBold = quickSandSemiBold
            self.quickSandBold = quickSandBold
        }
        
    }
}
