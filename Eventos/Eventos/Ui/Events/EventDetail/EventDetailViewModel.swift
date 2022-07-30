//
//  EventDetailViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

protocol EventDetailViewModelProtocol {
    var event: EventViewData { get }
    
    func makeCheckin()
}

final class EventDetailViewModel: EventDetailViewModelProtocol {
    
    let event: EventViewData
    
    init(event: EventViewData) {
        self.event = event
    }
    
    func makeCheckin() {
        //TODO: Checkin
    }
}
