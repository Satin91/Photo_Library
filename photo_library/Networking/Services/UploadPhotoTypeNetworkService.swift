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
    
    
    
    func uploadPhoto(name: String, id: Int, imageName: String, image: Data) {
        let request = UploadPhotoRequest(name: name, typeId: id, imageName: imageName, photo: image)
        manager.uploadPhoto(data: image, request: request)
    }
}
