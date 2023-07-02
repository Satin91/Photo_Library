//
//  NetworkManager.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine

class NetworkManager {
    let session = URLSession.shared
//
//    func sendRequest<T: Decodable>(request: URLRequest, model: T.Type) async throws -> T {
//        let (data, response) = try await URLSession.shared.data(for: request)
//        guard let httpResponse = response as? HTTPURLResponse,
//              (200...299).contains(httpResponse.statusCode) else {
//            throw NetworkError.badStatusCode
//        }
//
//        guard let decodedValue = try? JSONDecoder().decode(model.self, from: data) else {
//            throw NetworkError.wrongDecodingModel
//        }
//        return decodedValue
//    }
    
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
    
    func observeNetworkConnection() {
        
    }
}


