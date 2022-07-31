//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Combine

protocol EventsListViewModelProtocol {
    var events: [EventViewData] { get set }
    var viewStatusPublisher: AnyPublisher<ViewStatus, Never> { get }
    
    func getEvents()
    func selectEvent(at index: Int)
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    private let worker: GetEventsWorkerProtocol
    private let stateChangedSubject = PassthroughSubject<ViewStatus, Never>()
    
    var events: [EventViewData] = []
    var onSelectEvent: ((EventViewData) -> Void)?
    
    var viewStatusPublisher: AnyPublisher<ViewStatus, Never> {
        stateChangedSubject.eraseToAnyPublisher()
    }
    
    init(worker: GetEventsWorkerProtocol = EventsWorker()) {
        self.worker = worker
    }
    
    func selectEvent(at index: Int) {
        onSelectEvent?(events[index])
    }
    
    func getEvents() {
        stateChangedSubject.send(.loading)
        
        worker.getEvents { [weak self] result in
            switch result {
                
            case let .success(events):
                if events.isEmpty {
                    self?.events = []
                    self?.stateChangedSubject.send(.noResults)
                    return
                }
                
                self?.events = events
                self?.stateChangedSubject.send(.success)
            case let .failure(error):
                self?.stateChangedSubject.send(.error(error.errorDescription))
            }
        }
    }
}
