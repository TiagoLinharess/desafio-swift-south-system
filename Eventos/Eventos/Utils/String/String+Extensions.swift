//
//  String+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

extension String {
    
    func isEmail() -> Bool {
        let emailRegex = "[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}\\@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
