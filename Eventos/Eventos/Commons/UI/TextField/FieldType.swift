//
//  FieldType.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import UIKit

extension TextField {
    
    enum FieldType {
        case email, notEmpty
        
        var validator: Validator {
            switch self {
            case .email:
                return EmailValidator()
            case .notEmpty:
                return NotEmptyValidator()
            }
        }
        
        var autocapitalizationType: UITextAutocapitalizationType {
            switch self {
            case .email:
                return .none
            case .notEmpty:
                return .sentences
            }
        }
        
        var keyboardType: UIKeyboardType {
            switch self {
            case .email:
                return .emailAddress
            case .notEmpty:
                return .default
            }
        }
    }
}
