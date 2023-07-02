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
    
    func sendRequest<T: Decodable>(request: URLRequest, model: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (300...399).contains(httpResponse.statusCode) else {
            throw NetworkError.badStatusCode
        }
        
        guard let decodedValue = try? JSONDecoder().decode(model.self, from: data) else {
            throw NetworkError.wrongDecodingModel
        }
        return decodedValue
    }
}


