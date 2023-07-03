//
//  GetPhotoTypesRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Alamofire

struct GetPhotoTypesRequest: NetworkRequestProtocol {
    
    var parameters: [String: String]
    var header: [String: String]
    
    init(page: Int) {
        parameters = ["page": String(page)]
        header = ["Accept": "*/*"]
    }
    
    func make() -> RequestModel {
        let path = Endpoint.getPhotoTypes.rawValue.appendingQueryParameters(parameters)
        let headers = header.merging(header) { $1 }
        return RequestModel(path: path, headers: HTTPHeaders(headers), method: .get)
    }
}
