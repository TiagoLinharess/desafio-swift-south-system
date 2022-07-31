//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation

protocol EventsListViewModelProtocol {
    var events: [EventViewData] { get set }
    var viewStatus: Publisher<ViewStatus> { get }
    
    func getEvents()
    func selectEvent(at index: Int)
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    private let worker: GetEventsWorkerProtocol
    
    var events: [EventViewData] = []
    var onSelectEvent: ((EventViewData) -> Void)?
    
    var viewStatus = Publisher<ViewStatus>()
    
    init(worker: GetEventsWorkerProtocol = EventsWorker()) {
        self.worker = worker
    }
    
    func selectEvent(at index: Int) {
        onSelectEvent?(events[index])
    }
    
    func getEvents() {
        viewStatus.send(.loading)
        
        worker.getEvents { [weak self] result in
            switch result {
                
            case let .success(events):
                if events.isEmpty {
                    self?.events = []
                    self?.viewStatus.send(.noResults)
                    return
                }
                
                self?.events = events
                self?.viewStatus.send(.success)
            case let .failure(error):
                self?.viewStatus.send(.error(error.errorDescription))
            }
        }
    }
}
