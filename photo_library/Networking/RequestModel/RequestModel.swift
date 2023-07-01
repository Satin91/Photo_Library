//
//  RequestModel.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

protocol RequestModel {
    var url: URL { get set }
    var method: HTTPMethod { get set }
    var params: [String: String] { get set }
    
}

extension RequestModel {
    func make() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        return request
    }
}
