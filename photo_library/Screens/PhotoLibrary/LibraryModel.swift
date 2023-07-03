//
//  LibraryPhotoModel.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

struct PhotoTypeModel {
    var name: String
    var id: Int
    var image: UIImage?
}

struct PhotoUploadModel {
    var image: Data
    var imageName: String
}
