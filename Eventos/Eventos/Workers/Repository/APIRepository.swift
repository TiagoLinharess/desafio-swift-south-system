//
//  APIRepository.swift
//  Eventos
//
//  Created by Tiago Linhares on 29/07/22.
//

import Foundation

protocol RepositoryProtocol {
    var baseUrl: String { get }
    
    func callMethod(endpoint: Endpoint, completion: @escaping (Result<Data, RequestError>) -> ())
}

struct APIRepository: RepositoryProtocol {
    let baseUrl = "http://5f5a8f24d44d640016169133.mockapi.io/api"
    
    func callMethod(endpoint: Endpoint, completion: @escaping (Result<Data, RequestError>) -> ()) {
        let url = URL(string:"\(baseUrl)\(endpoint.endpoint)")
        guard let url = url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.httpBody = endpoint.params?.toData
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let responseCode = response as? HTTPURLResponse, let data = data else {
                let error = RequestError(errorDescription: "Não foi possível obter resposta do servidor.")
                completion(.failure(error))
                return
            }
            
            if let error = error {
                completion(.failure(RequestError(errorDescription: error.localizedDescription)))
                return
            }
            
            if responseCode.statusCode == 404 {
                completion(.failure(RequestError(errorDescription: "Nenhum evento encontrado")))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
