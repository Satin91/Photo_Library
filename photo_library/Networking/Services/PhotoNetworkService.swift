//
//  NetworkService.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine

class PhotoNetworkService {
    let manager = NetworkManager()
    var subscriber = Set<AnyCancellable>()
    
    func loadPhotos(page: Int) -> AnyPublisher<[LibraryPhotoModel], Error> {
        let request = GetPhotoTypesRequest(page: page).make()
        return manager.sendRequest(request: request)
            .print("retry")
            .decode(type: GetPhotoTypeResponse.self, decoder: JSONDecoder())
            .map { $0.content }
            .map { array -> [LibraryPhotoModel] in
                array.map { element in
                    self.convertToLibraryModel(element: element)
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func convertToLibraryModel(element: Content) -> LibraryPhotoModel {
        var model = LibraryPhotoModel(name: "", id: 0)
        model.image = loadImage(urlString: element.image)
        model.name = element.name
        model.id = element.id
        return model
    }
    
    private func loadImage(urlString: String?) -> UIImage? {
        guard let url = URL(string: urlString ?? "") else {
            return nil
        }
        let imageData = try? Data(contentsOf: url)
        return UIImage(data: imageData ?? Data())
    }
}
