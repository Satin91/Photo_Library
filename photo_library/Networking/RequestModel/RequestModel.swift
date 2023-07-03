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
    var parameters: [String : Any]?
    var method: Alamofire.HTTPMethod
    var headers: HTTPHeaders
    
    var baseUrl: String {
        Constats.API.libraryHost
    }
    var encoding: ParameterEncoding {
        JSONEncoding.default
    }
    
    init(path: String, parameters: [String: Any]? = nil, headers: HTTPHeaders = HTTPHeaders(), method: Alamofire.HTTPMethod = .get) {
        self.path = path
        self.parameters = parameters
        self.method = method
        self.headers = headers
    }
}
