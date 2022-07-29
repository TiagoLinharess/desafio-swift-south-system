//
//  Endpoint.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    
    var endpoint: String { get set }
    var method: HTTPMethod { get set }
    var params: [String: Any]? { get set }
}
