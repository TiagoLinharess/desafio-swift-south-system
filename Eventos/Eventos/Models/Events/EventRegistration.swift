//
//  EventRegistration.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

struct EventRegistration: Encodable {
    
    let eventId: String
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case eventId, name, email
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(eventId, forKey: .eventId)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}
