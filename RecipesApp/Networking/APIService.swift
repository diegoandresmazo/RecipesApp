//
//  APIService.swift
//  RecipesApp
//
//  Created by Diego Andres Mazo Munoz on 31/10/22.
//

import Foundation
import Combine

public protocol APIServiceType {
    func call<T: Decodable>(_ request: URLRequest, urlSession: URLSession, type: T.Type) -> AnyPublisher<T, CloudError>
}

/**
 * The API is called and an attempt is made to decode to the API of the type T: (Generic)
 */
struct APIService: APIServiceType {
    func call<T: Decodable>(_ request: URLRequest, urlSession: URLSession, type: T.Type) -> AnyPublisher<T, CloudError> {
        return urlSession
            .dataTaskPublisher(for: request)
            .mapError({ urlError in
                return CloudError.server(error: urlError)
            })
            .tryMap { result -> T in
                let decoder = JSONDecoder()
                return try decoder.decode(T.self, from: result.data)
            }
            .mapError({ error in
                return CloudError.decode(error: error)
            })
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
