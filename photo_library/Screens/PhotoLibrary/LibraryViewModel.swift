//
//  LibraryViewModel.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation
import Combine

class LibraryViewModel {
    let networkService = NetworkService()
    var content = CurrentValueSubject<[[Content]], Never>([])
    
    var pageForLoad: Int = 0

    init() {
        getPhotoTypes()
    }
    
    func loadNextPage() {
        pageForLoad += 1
        getPhotoTypes()
    }
    
    private func getPhotoTypes() {
        Task {
            do {
                let photoTypes = try await networkService.loadPhotos(page: pageForLoad)
                content.value.append(photoTypes.content)
            } catch let error as NetworkError {
                print(error)
            }
        }
    }
}
