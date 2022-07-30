//
//  Validators.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

protocol Validator {
    
    func validate(text: String, fieldName: String) throws
}

struct NotEmptyValidator: Validator {
    
    func validate(text: String, fieldName: String) throws {
        guard text.count > 0 else { throw TextField._Error.empty(fieldName) }
    }
}

struct EmailValidator: Validator {
    
    func validate(text: String, fieldName: String) throws {
        guard text.isEmail() else { throw TextField._Error.invalid(fieldName) }
    }
}
