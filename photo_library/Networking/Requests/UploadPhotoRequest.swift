//
//  UploadPhotoRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation
import Alamofire

/// Запрос на отправку фотографий на сервер
struct UploadPhotoRequest: NetworkRequestProtocol {
    
    var parameters: [String: String]
    var header: [String: String]
    
    init(name: String, typeId: Int, imageName: String, photo: Data) {
        parameters = [
            "name": name,
            "typeId": String(typeId),
        ]
        header = ["Content-Type": "multipart/form-data"]
    }
    
    /// Обязательный метода протокола
    func make() -> RequestModel {
        let headers = header.merging(header) { $1 }
        return RequestModel(path: .uploadPhoto, parameters: parameters, headers: HTTPHeaders(headers), method: .post)
    }
}

