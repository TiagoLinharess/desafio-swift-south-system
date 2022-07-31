//
//  EventCheckinViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Foundation

protocol EventCheckinViewModelProtocol {
    var event: EventViewData { get }
    var checkinStatusPublisher: Publisher<ViewStatus> { get }
    var onCheckin: (() -> Void)? { get set }
    
    func makeCheckin(email: String, name: String)
}

final class EventCheckinViewModel: EventCheckinViewModelProtocol {
    
    private let worker: PostEventCheckinWorkerProtocol
    
    var event: EventViewData
    var onCheckin: (() -> Void)?
    var checkinStatusPublisher = Publisher<ViewStatus>()
    
    init(event: EventViewData, onCheckin: (() -> Void)?, worker: PostEventCheckinWorkerProtocol = EventsWorker()) {
        self.event = event
        self.worker = worker
        self.onCheckin = onCheckin
    }
    
    func makeCheckin(email: String, name: String) {
        checkinStatusPublisher.send(.loading)
        let registration = EventRegistration(eventId: event.id, name: name, email: email)

        worker.makeCheckin(with: registration) { [weak self] result in
            switch result {
            case .success(_):
                self?.checkinStatusPublisher.send(.success)
            case let .failure(error):
                self?.checkinStatusPublisher.send(.error(error.localizedDescription))
            }
        }
    }
}
