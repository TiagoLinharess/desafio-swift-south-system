//
//  TextFieldError.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

struct TextFieldError: Error {
    
    let message: String
    
    init(_ message: String) {
        self.message = message
    }
}
