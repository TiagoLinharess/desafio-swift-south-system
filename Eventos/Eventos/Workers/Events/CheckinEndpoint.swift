//
//  CheckinEndpoint.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

struct CheckinEndpoint: Endpoint {
    
    var endpoint: String = "/checkin"
    var method: HTTPMethod = .post
    var params: [String : Any]?
    
    init(registration: EventRegistration) {
        self.params = registration.dictionary
    }
}
