//
//  EventInfoViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

protocol EventInfoViewModelProtocol {
    var event: EventViewData { get }
}

final class EventInfoViewModel: EventInfoViewModelProtocol {
    
    let event: EventViewData
    
    init(event: EventViewData) {
        self.event = event
    }
}
