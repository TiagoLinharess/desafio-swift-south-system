//
//  Dictionary+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 31/07/22.
//

import Foundation

extension Dictionary {
    
    var toData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
