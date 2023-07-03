//
//  UploadPhotoResponse.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import Foundation

/// Модель для декодирования ответа отправки фотографии
struct UploadPhotoResponse: Decodable {
    var id: String
}
