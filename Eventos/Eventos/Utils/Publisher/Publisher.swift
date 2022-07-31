//
//  Publisher.swift
//  Eventos
//
//  Created by Tiago Linhares on 31/07/22.
//

import Combine
import UIKit

class Publisher<T> {
    
    private let subject = PassthroughSubject<T, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var publisher: AnyPublisher<T, Never> {
        subject.eraseToAnyPublisher()
    }
    
    var value: T?
    
    func send(_ object: T) {
        subject.send(object)
        value = object
    }
    
    func sink(_ completion: @escaping (T) -> Void) {
        publisher
            .debounce(for: 0, scheduler: DispatchQueue.main)
            .sink(receiveValue: completion)
            .store(in: &cancellables)
    }
}
