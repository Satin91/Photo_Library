//
//  UploadPhotoTypeNetworkService.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation
import Combine

class UploadPhotoTypeNetworkService {
    let manager = NetworkManager()
    private var subscriber = Set<AnyCancellable>()
    
    
    
    func uploadPhoto(name: String, id: Int, imageName: String, photo: Data) {
        let request = UploadPhotoRequest(name: name, typeId: id, imageName: imageName, photo: photo)
        manager.uploadPhoto(data: photo, request: request)
    }
}
