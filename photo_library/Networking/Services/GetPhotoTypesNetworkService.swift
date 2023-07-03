//
//  NetworkService.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine
import Alamofire

class NetworkService {
    private let manager = NetworkManager()
    private var subscriber = Set<AnyCancellable>()
    
    func loadPhotos(page: Int) -> AnyPublisher<[LibraryPhotoModel], Error> {
        let request = GetPhotoTypesRequest(page: page)
        return manager.sendRequest(request: request)
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
        let image = loadImage(urlString: element.image)
        return LibraryPhotoModel(name: element.name, id: element.id, image: image)
    }
    
    private func loadImage(urlString: String?) -> UIImage? {
        guard let url = URL(string: urlString ?? "") else {
            return nil
        }
        let imageData = try? Data(contentsOf: url)
        return UIImage(data: imageData ?? Data())
    }
    
    func uploadPhoto(name: String, id: Int, imageName: String, image: Data) -> Future<Bool, AFError> {
        let request = UploadPhotoRequest(name: name, typeId: id, imageName: imageName, photo: image)
        return manager.uploadPhoto(data: image, name: imageName, request: request)
    }
}
