//
//  EventCheckinViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 30/07/22.
//

import Combine

protocol EventCheckinViewModelProtocol {
    var event: EventViewData { get }
    var checkinStatusPublisher: AnyPublisher<ViewStatus, Never> { get }
    
    func makeCheckin(email: String, name: String)
}

final class EventCheckinViewModel: EventCheckinViewModelProtocol {
    
    private let stateChangedSubject = PassthroughSubject<ViewStatus, Never>()
    private let worker: PostEventCheckinWorkerProtocol
    
    var event: EventViewData
    
    var checkinStatusPublisher: AnyPublisher<ViewStatus, Never> {
        stateChangedSubject.eraseToAnyPublisher()
    }
    
    init(event: EventViewData, worker: PostEventCheckinWorkerProtocol = EventsWorker()) {
        self.event = event
        self.worker = worker
    }
    
    func makeCheckin(email: String, name: String) {
        stateChangedSubject.send(.loading)
        let registration = EventRegistration(eventId: event.id, name: name, email: email)

        worker.makeCheckin(with: registration) { [weak self] result in
            switch result {
            case .success(_):
                self?.stateChangedSubject.send(.success)
            case let .failure(error):
                self?.stateChangedSubject.send(.error(error.localizedDescription))
            }
        }
    }
}
