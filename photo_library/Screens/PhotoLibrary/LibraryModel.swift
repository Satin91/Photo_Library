//
//  LibraryPhotoModel.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

/// Модель, которая работает в UI
struct PhotoTypeModel {
    var name: String
    var id: Int
    var image: UIImage?
}

/// Модель фотографии для отправки
struct PhotoUploadModel {
    var image: Data
    var imageName: String
}
