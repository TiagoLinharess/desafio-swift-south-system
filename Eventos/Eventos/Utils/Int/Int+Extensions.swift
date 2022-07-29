//
//  Int+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

extension Int {
    
    func timeStampToDateFormat() -> String {
        let timeInterval = TimeInterval(self)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        return date.dateFormat()
    }
}
