//
//  LibraryViewModel.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine

class LibraryViewModel {
    let photoNetworkSerivce = PhotoNetworkService()
    var content = CurrentValueSubject<[[LibraryPhotoModel]], Never>([])
    var error = PassthroughSubject<Error, Never>()
    var subscriber = Set<AnyCancellable>()
    var pageForLoad: Int = 0
    
    init() {
        getPhotoTypes()
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
