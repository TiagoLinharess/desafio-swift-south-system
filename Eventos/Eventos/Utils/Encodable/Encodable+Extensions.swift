//
//  Encodable+Extensions.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

extension Encodable {
    
    var dictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
    }
}

extension Dictionary {
    
    var toData: Data? {
        try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
