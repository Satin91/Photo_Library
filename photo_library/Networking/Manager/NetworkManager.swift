//
//  NetworkManager.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine

class NetworkManager {
    private let session = URLSession.shared
    
    func sendRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
        guard let url = request.url else {
            return Fail(error: NetworkError.badURL).eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw NetworkError.badStatusCode
                }
                return element.data
            }
            .eraseToAnyPublisher()
    }
}


