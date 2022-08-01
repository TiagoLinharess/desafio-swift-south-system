//
//  EventDetailViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

protocol EventDetailViewModelProtocol {
    var event: EventViewData { get }
    
    func onCheckin()
    func onShare()
}

final class EventDetailViewModel: EventDetailViewModelProtocol {
    
    let event: EventViewData
    
    var checkinDidMake: (() -> Void)?
    var share: ((EventViewData) -> Void)?
    
    init(event: EventViewData) {
        self.event = event
    }
    
    func onCheckin() {
        checkinDidMake?()
    }
    
    func onShare() {
        share?(event)
    }
}
