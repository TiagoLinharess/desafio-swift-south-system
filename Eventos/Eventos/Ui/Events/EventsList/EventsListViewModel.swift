//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation
import RxSwift

protocol EventsListViewModelProtocol {
    var events: [Int] { get set }
    var viewStatus: PublishSubject<ViewStatus> { get set }
    
    func getEvents()
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    var events: [Int] = []
    var viewStatus = PublishSubject<ViewStatus>()
    
    init() {

    }
    
    func getEvents() {
        viewStatus.onNext(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewStatus.onNext(.success)
        }
    }
}
