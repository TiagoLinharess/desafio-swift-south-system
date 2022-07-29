//
//  Date+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

extension Date {
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self)
    }
}
