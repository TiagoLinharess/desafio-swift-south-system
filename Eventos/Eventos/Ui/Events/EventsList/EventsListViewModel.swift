//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation
import RxSwift

protocol EventsListViewModelProtocol {
    var events: [EventViewData] { get set }
    var viewStatus: PublishSubject<ViewStatus> { get set }
    
    func getEvents()
    func selectEvent(at index: Int)
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    var events: [EventViewData] = []
    var viewStatus = PublishSubject<ViewStatus>()
    var onSelectEvent: ((EventViewData) -> Void)?
    
    private let worker: GetEventsWorkerProtocol
    
    init(worker: GetEventsWorkerProtocol = EventsWorker()) {
        self.worker = worker
    }
    
    func selectEvent(at index: Int) {
        onSelectEvent?(events[index])
    }
    
    func getEvents() {
        viewStatus.onNext(.loading)
        
        worker.getEvents { [weak self] result in
            switch result {
                
            case let .success(events):
                if events.isEmpty {
                    self?.events = []
                    self?.viewStatus.onNext(.noResults)
                    return
                }
                
                self?.events = events
                self?.viewStatus.onNext(.success)
            case let .failure(error):
                self?.viewStatus.onNext(.error(error.errorDescription))
            }
        }
    }
}
