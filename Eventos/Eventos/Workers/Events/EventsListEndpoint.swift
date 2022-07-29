//
//  EventsEndpoint.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

struct EventsListEndpoint: Endpoint {
    var endpoint: String = "/events"
    var method: HTTPMethod = .get
    var params: [String : Any]? = nil
}
