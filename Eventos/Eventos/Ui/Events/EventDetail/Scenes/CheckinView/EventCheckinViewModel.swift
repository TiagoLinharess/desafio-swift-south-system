//
//  EventCheckinViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation
import RxSwift

protocol EventCheckinViewModelProtocol {
    var event: EventViewData { get }
    var checkinStatus: PublishSubject<ViewStatus> { get set }
    
    func makeCheckin(email: String, name: String)
}

final class EventCheckinViewModel: EventCheckinViewModelProtocol {
    
    var event: EventViewData
    var checkinStatus = PublishSubject<ViewStatus>()
    
    init(event: EventViewData) {
        self.event = event
    }
    
    func makeCheckin(email: String, name: String) {
        checkinStatus.onNext(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.checkinStatus.onNext(.success)
        }
    }
}
