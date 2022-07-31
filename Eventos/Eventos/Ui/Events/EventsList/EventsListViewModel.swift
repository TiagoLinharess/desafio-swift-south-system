//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation

protocol EventsListViewModelProtocol {
    var events: [EventViewData] { get set }
    var viewStatusPublisher: Publisher<ViewStatus> { get }
    
    func getEvents()
    func selectEvent(at index: Int)
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    private let worker: GetEventsWorkerProtocol
    
    var events: [EventViewData] = []
    var onSelectEvent: ((EventViewData) -> Void)?
    
    var viewStatusPublisher = Publisher<ViewStatus>()
    
    init(worker: GetEventsWorkerProtocol = EventsWorker()) {
        self.worker = worker
    }
    
    func selectEvent(at index: Int) {
        onSelectEvent?(events[index])
    }
    
    func getEvents() {
        viewStatusPublisher.send(.loading)
        
        worker.getEvents { [weak self] result in
            switch result {
                
            case let .success(events):
                if events.isEmpty {
                    self?.events = []
                    self?.viewStatusPublisher.send(.noResults)
                    return
                }
                
                self?.events = events
                self?.viewStatusPublisher.send(.success)
            case let .failure(error):
                self?.viewStatusPublisher.send(.error(error.errorDescription))
            }
        }
    }
}
