//
//  EventViewData.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation

struct EventViewData {
    
    let id: String
    let title: String
    let price: Double
    let image: String
    let description: String
    let date: Int
    
    init(from dto: EventDto) {
        self.id = dto.id
        self.title = dto.title
        self.price = dto.price
        self.image = dto.image
        self.description = dto.description
        self.date = dto.date
    }
}
