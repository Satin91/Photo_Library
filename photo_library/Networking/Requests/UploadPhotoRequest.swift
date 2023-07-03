//
//  UploadPhotoRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation
import Alamofire

struct UploadPhotoRequest: NetworkRequestProtocol {
    
    var parameters: [String: String]
    var header: [String: String]
    var body: [String: Any]
    
    init(name: String, typeId: Int, imageName: String, photo: Data) {
        parameters = [
            "name": name,
            "typeId": String(typeId),
        ]
        header = ["Content-Type": "multipart/form-data"]
        body = ["\(imageName)": photo]
    }
    
    func make() -> RequestModel {
        let headers = header.merging(header) { $1 }
        return RequestModel(path: .uploadPhoto, parameters: parameters, body: body, headers: HTTPHeaders(headers), method: .post)
    }
}

