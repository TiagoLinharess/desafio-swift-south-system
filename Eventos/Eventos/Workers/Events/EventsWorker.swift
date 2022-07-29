//
//  EventsWorker.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

protocol GetEventsWorkerProtocol {
    func getEvents(completion: @escaping (Result<[EventViewData], RequestError>) -> Void)
}

struct EventsWorker: GetEventsWorkerProtocol {
    
    private let repository: RepositoryProtocol
    
    init(repository: RepositoryProtocol = APIRepository()) {
        self.repository = repository
    }
    
    func getEvents(completion: @escaping (Result<[EventViewData], RequestError>) -> Void) {
        repository.callMethod(endpoint: EventsListEndpoint()) { result in
            switch result {
                
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let eventsDto = try decoder.decode([EventDto].self, from: data)
                    let eventsViewData = eventsDto.map { dto -> EventViewData in
                        EventViewData(from: dto)
                    }
                    
                    DispatchQueue.main.async {
                        completion(.success(eventsViewData))
                    }
                } catch let error {
                    completion(.failure(RequestError(errorDescription: error.localizedDescription)))
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
