//
//  LibraryViewModel.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine
import UIKit

class LibraryViewModel {
    let photoNetworkSerivce = GetPhotoTypesNetworkService()
    let sendPhotoService = UploadPhotoTypeNetworkService()
    var content = CurrentValueSubject<[[LibraryPhotoModel]], Never>([])
    var error = PassthroughSubject<Error, Never>()
    var subscriber = Set<AnyCancellable>()
    var pageForLoad: Int = 0
    
    init() {
        getPhotoTypes()
        let image = UIImage(named: "placeholder")!
        let data = image.jpegData(compressionQuality: 1)!
//        sendPhotoService.uploadPhoto(name: "name", id: 26, photo: data)
    }
    
    func loadNextPage() {
        pageForLoad += 1
        getPhotoTypes()
    }
    
    private func getPhotoTypes() {
        photoNetworkSerivce.loadPhotos(page: pageForLoad)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error.send(error)
                case .finished:
                    break
                }
            } receiveValue: { photos in
                self.content.value.append(photos)
            }
            .store(in: &subscriber)
    }
}
