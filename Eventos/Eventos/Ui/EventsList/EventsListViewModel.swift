//
//  EventsListViewModel.swift
//  Eventos
//
//  Created by Tiago Linhares on 28/07/22.
//

import Foundation

protocol EventsListViewModelProtocol {
    var events: [Int] { get set }
}


class EventsListViewModel: EventsListViewModelProtocol {
    
    var events: [Int] = []
}
