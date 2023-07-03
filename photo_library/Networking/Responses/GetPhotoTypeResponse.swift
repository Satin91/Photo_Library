//
//  GetPhotoTypeResponse.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import Foundation

/// Модель для декодирования ответа получения типов фотографий
struct GetPhotoTypeResponse: Decodable {
    let page, pageSize, totalPages, totalElements: Int
    let content: [Content]
}

struct Content: Decodable {
    let id: Int
    let name: String
    let image: String?
}
