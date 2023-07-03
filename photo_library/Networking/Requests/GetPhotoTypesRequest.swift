//
//  GetPhotoTypesRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Alamofire

/// Запрос на получение типов фотографий
struct GetPhotoTypesRequest: NetworkRequestProtocol {
    
    var parameters: [String: String]
    var header: [String: String]
    
    init(page: Int) {
        parameters = ["page": String(page)]
        header = ["Accept": "*/*"]
    }
    
    /// Обязательный метод протокола
    func make() -> RequestModel {
        let headers = header.merging(header) { $1 }
        return RequestModel(path: .getPhotoTypes, parameters: parameters, headers: HTTPHeaders(headers), method: .get)
    }
}
