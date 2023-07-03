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
    
    /// Общий метод для построения запросов
    func sendRequest(request: NetworkRequestProtocol) -> AnyPublisher<Data, Error> {
        let request = request.make()
        return session.request(request.fullPath, method: request.method, parameters: request.body, encoding: request.encoding, headers: request.headers).publishData()
            .tryMap { response -> Data in
                switch response.result {
                case .success(let data):
                    return data
                case .failure(let error):
                    throw error
                }
            }
            .eraseToAnyPublisher()
    }
    
    /// Метод для загрузки фото на сервер
    func uploadPhoto(data: Data, name: String, request: NetworkRequestProtocol) -> AnyPublisher<Data, Error>{
        let request = request.make()
        return Future { promise in
            self.session.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "photo" , fileName: name)
            },
                      to: request.fullPath, method: request.method)
            .response { response in
                switch response.result {
                case .success(let data):
                    promise(.success(data!))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
