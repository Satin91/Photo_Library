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
    
    
    //    func uploadPhoto(name: String, id: Int, photo: Data) {
    //        var URL = URL(string: "https://junior.balinasoft.com/api/v2/photo")
    //        let URLParams = [
    //            "name": name,
    //            "typeId": "\(id)",
    //        ]
    //        URL = URL!.appendingQueryParameters(URLParams)
    //        var request = URLRequest(url: URL!)
    //        request.addValue("*/*", forHTTPHeaderField: "Accept")
    //        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
    //        request.httpMethod = "POST"
    //        request.httpBody = photo
    //
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            print("Data \(String(data: data!, encoding: .utf8) )")
    //            print("response \(response)")
    //            print("error \(error)")
    //        }.resume()
    //    }
    
//    func uploadPhoto(name: String, id: Int, photo: Data) {
//        let request = UploadPhotoRequest(name: name, photo: photo, typeId: "\(id)").make()
//        manager.sendRequest(request: request)
//            .sink { error in
//                switch error {
//                case .finished:
//                    break
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            } receiveValue: { data in
//                let json = String(data: data, encoding: .utf8)
//                print("Receiving data \(json)")
//            }
//            .store(in: &subscriber)
//    }
}
