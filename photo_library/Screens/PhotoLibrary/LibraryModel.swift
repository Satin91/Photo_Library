//
//  LibraryPhotoModel.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

struct LibraryPhotoModel {
    var name: String
    var id: Int
    var image: UIImage?
}

struct PickerModel {
    var image: Data
    var imageName: String
}
