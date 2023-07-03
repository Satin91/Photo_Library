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
    
    func uploadPhoto(data: Data, name: String, request: NetworkRequestProtocol) -> Future<Bool, AFError>{
        Future { promise in
            let request = request.make()
            AF.upload(multipartFormData: { multipartFormData in
                multipartFormData.append(data, withName: "photo" , fileName: name)
            },
                      to: request.fullPath, method: .post)
            .response { resp in
                if resp.data != nil {
                    promise(.success(true))
                } else {
                    promise(.failure(resp.error!))
                }
            }
        }
    }
    
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
}
