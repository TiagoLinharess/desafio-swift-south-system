//
//  TextFieldError.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

extension TextField {
    
    enum _Error: Error {
        case empty(String), invalid(String)
        
        var message: String {
            switch self {
            case let .empty(field):
                return "\(field) é obrigatório"
            case let .invalid(field):
                return "\(field) inválido"
            }
        }
    }
}
