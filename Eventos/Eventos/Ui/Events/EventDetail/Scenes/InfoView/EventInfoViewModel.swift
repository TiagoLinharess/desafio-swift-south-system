//
//  EventInfoViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

protocol EventInfoViewModelProtocol {
    var event: EventViewData { get }
    
    func share()
}

final class EventInfoViewModel: EventInfoViewModelProtocol {
    
    let event: EventViewData
    
    var onShare: (() -> Void)?
    
    init(event: EventViewData, onShare: (() -> Void)?) {
        self.event = event
        self.onShare = onShare
    }
    
    func share() {
        onShare?()
    }
}
