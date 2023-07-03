//
//  RequestModel.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

import Foundation
import Alamofire

// Протокол, который должны реализовать все объекты запросов.
// Запросы создаются отдельно и инициализируют обязательные свойства структуры RequestModel
protocol NetworkRequestProtocol {
    func make() -> RequestModel
}

// рeaders, baseURL, encoding,  объявлены геттерами для улучшения читаемости. В реальном проекте, они были бы обычными глобальными свойствами.
struct RequestModel {
    var path: String
    var body: [String : Any]?
    var method: Alamofire.HTTPMethod
    var headers: HTTPHeaders
    
    var host: String {
        Constats.API.libraryHost
    }
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
    var fullPath: String {
        host + path
    }
    
    init(path: Endpoint, parameters: [String: String] = [:], body: [String: Any]? = nil, headers: HTTPHeaders = HTTPHeaders(), method: Alamofire.HTTPMethod = .get) {
        self.path = path.rawValue.appendingQueryParameters(parameters)
        self.body = body
        self.method = method
        self.headers = headers
    }
}
