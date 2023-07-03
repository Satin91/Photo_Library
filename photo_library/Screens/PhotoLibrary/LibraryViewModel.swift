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
    var photoTypes = CurrentValueSubject<[[PhotoTypeModel]], Never>([])
    var error = PassthroughSubject<Error, Never>()
    var subscriber = Set<AnyCancellable>()
    var pageForLoad: Int = 0
    var selectedIndex: [Int] = []
    
    init() {
        getPhotoTypes()
    }
    
    /// Запрос на загрузку фотографий
    private func getPhotoTypes() {
        networkService.loadPhotoTypes(from: pageForLoad)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error.send(error)
                case .finished:
                    break
                }
            } receiveValue: { photos in
                self.photoTypes.value.append(photos)
            }
            .store(in: &subscriber)
    }
    
    /// Запрос на загрузку фотографий со следующей страницы ( запускается при прокрутке )
    func loadNextPage() {
        pageForLoad += 1
        getPhotoTypes()
    }
    
    /// Загрузка выбранной фотографии на сервер и, при успешной загрузке, смена фотографии в выбранной ячейке
    func uploadPhoto(photo: PhotoUploadModel) {
        let selectedType = photoTypes.value[selectedIndex]
        networkService.uploadPhoto(name: "Кулик Артур Сергеевич", id: selectedType.id, imageName: photo.imageName, image: photo.image)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    self.error.send(error)
                case .finished:
                    break
                }
            } receiveValue: { [self] _ in
                photoTypes.value[selectedIndex].image = UIImage(data: photo.image)
            }
            .store(in: &subscriber)

    }
}
