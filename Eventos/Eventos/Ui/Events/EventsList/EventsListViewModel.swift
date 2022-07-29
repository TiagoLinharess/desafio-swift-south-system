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
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    var events: [EventViewData] = []
    var viewStatus = PublishSubject<ViewStatus>()
    
    init() {

    }
    
    func getEvents() {
        viewStatus.onNext(.loading)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.events = [.init(
                id: "0",
                title: "aaaaa",
                price: 20.00,
                image: "http://lproweb.procempa.com.br/pmpa/prefpoa/seda_news/usu_img/Papel%20de%20Parede.png",
                description: "ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc",
                date: "30/09/2000"
            )
            ]
            self.viewStatus.onNext(.noResults)
        }
    }
}
