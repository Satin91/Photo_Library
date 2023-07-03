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
    let networkService = NetworkService()
    var content = CurrentValueSubject<[[LibraryPhotoModel]], Never>([])
    var error = PassthroughSubject<Error, Never>()
    var subscriber = Set<AnyCancellable>()
    var pageForLoad: Int = 0
    var selectedTypeIndex: [Int] = []
    
    init() {
        getPhotoTypes()
    }
    
    func loadNextPage() {
        pageForLoad += 1
        getPhotoTypes()
    }
    
    func uploadPhoto(photo: PickerModel) {
        let selectedType = content.value[selectedTypeIndex]
        networkService.uploadPhoto(name: "Кулик Артур Сергеевич", id: selectedType.id, imageName: photo.imageName, image: photo.image)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error.send(error)
                case .finished:
                    break
                }
            } receiveValue: { [self] success in
                content.value[selectedTypeIndex].image = UIImage(data: photo.image)
            }
            .store(in: &subscriber)

    }
    
    private func getPhotoTypes() {
        networkService.loadPhotos(page: pageForLoad)
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
