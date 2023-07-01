//
//  NetworkManager.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

class NetworkManager {
    let session = URLSession.shared
    
    func sendRequest<T: Decodable>(request: URLRequest, model: T.Type) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data)
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badURL)
        }

        guard let decodedValue = try? JSONDecoder().decode(model.self, from: data) else {
            throw URLError(.cancelled)
        }

        return decodedValue
    }
}


