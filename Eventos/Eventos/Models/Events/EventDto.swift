//
//  EventDto.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

struct EventDto: Decodable {
    
    let id: String
    let title: String
    let price: Double
    let image: String
    let description: String
    let date: Int
}
