//
//  NetworkError.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case badStatusCode
    case noInternet
    case wrongDecodingModel
    case noData
    
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Bad URL"
        case .badStatusCode:
            return "Bad status code"
        case .noInternet:
            return "No internet connection"
        case .wrongDecodingModel:
            return "Wrong decoding model"
        case .noData:
            return "No data from server"
        }
    }
}
