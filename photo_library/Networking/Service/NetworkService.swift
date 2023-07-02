//
//  NetworkService.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

class NetworkService {
    let manager = NetworkManager()
    
    func loadPhotos(page: Int) async throws -> GetPhotoTypeResponse {
        let request = GetPhotoTypesRequest(page: page).make()
        let photoTypes = try await manager.sendRequest(request: request, model: GetPhotoTypeResponse.self)
        return photoTypes
    }
}
