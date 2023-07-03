//
//  NetworkManager.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine
import Alamofire

class NetworkManager {
    private let session = Session.default
    
    func sendRequest(request: NetworkRequestProtocol) -> AnyPublisher<Data, Error> {
        let request = request.make()
        return session.request(request.baseUrl + request.path, method: request.method, parameters: request.parameters, encoding: request.encoding, headers: request.headers).publishData()
            .tryMap { response -> Data in
                switch response.result {
                case .success(let data):
                    let serialize = try! JSONSerialization.jsonObject(with: data)
                    print("Response data \(serialize)")
                    return data
                case .failure(let error):
                    print("Response error \(error)")
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
}



//    func sendRequest(request: URLRequest) -> AnyPublisher<Data, Error> {
//        guard let url = request.url else {
//            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//        }
//        return session.dataTaskPublisher(for: url)
//            .tryMap { element -> Data in
////                guard let httpResponse = element.response as? HTTPURLResponse,
////                      httpResponse.statusCode == 200 else {
////                    throw NetworkError.badStatusCode
////                }
//                return element.data
//            }
//            .eraseToAnyPublisher()
//    }
//
