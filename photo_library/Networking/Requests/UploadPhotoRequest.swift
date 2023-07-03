//
//  UploadPhotoRequest.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation

struct UploadPhotoRequest {
    var name: String
    var photo: Data
    var typeId: String
    
    init(name: String, photo: Data, typeId: String) {
        self.name = name
        self.photo = photo
        self.typeId = typeId
    }
    
    func make() -> URLRequest {
        var URL = URL(string: "https://junior.balinasoft.com/api/v2/photo")
        let URLParams = [
            "name": name,
            "typeId": typeId,
        ]
        var request = URLRequest(url: URL!)
        request.addValue("*/*", forHTTPHeaderField: "Accept")
        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "HEAD"
        request.httpBody = photo
        return request
    }
}
