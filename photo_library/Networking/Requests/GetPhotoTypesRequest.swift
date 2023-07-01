//
//  GetPhotoTypesRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

struct GetPhotoTypesRequest: RequestModel {
    var method: HTTPMethod
    var url: URL
    var params: [String : String]
    
    init(page: Int) {
        params = ["page": String(page)]
        url = URL(string: Constats.API.libraryHost + Endpoint.getPhotoTypes.rawValue)!.appendingQueryParameters(params)
        method = .get
    }
}
