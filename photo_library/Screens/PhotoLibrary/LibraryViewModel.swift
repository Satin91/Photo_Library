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
    
    var currentPage: Int = 0
    
    init() {
        getPhotoTypes()
    }
    
    func loadNextPage() {
        currentPage += 1
        getPhotoTypes()
    }
    
    func getPhotoTypes() {
        Task {
            do {
                let photoTypes = try await networkService.getPhotoTypesRequest(page: currentPage)
                content.value.append(photoTypes.content)
//                content.send(photoTypes.content)
            } catch let error {
                print("Ошибка загрзки")
            }
        }
    }
}
