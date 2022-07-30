//
//  EventCheckinViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

protocol EventCheckinViewModelProtocol {
    var event: EventViewData { get }
    
    func makeCheckin()
}

final class EventCheckinViewModel: EventCheckinViewModelProtocol {
    
    var event: EventViewData
    
    init(event: EventViewData) {
        self.event = event
    }
    
    func makeCheckin() {
        //TODO: Checkin
    }
}
