//
//  ImagePickerManager.swift
//  photo_library
//
//  Created by Артур Кулик on 03.07.2023.
//

import UIKit
import Combine

class ImagePickerManager: NSObject {
    let pickerController = UIImagePickerController()
    var selectedImage = PassthroughSubject<PickerModel, Never>()
    
    override init() {
        super.init()
        pickerController.delegate = self
    }
}

extension ImagePickerManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let imagePath = info[UIImagePickerController.InfoKey.imageURL] as! URL
        let imageData = image.jpegData(compressionQuality: 0.2) ?? Data()
        let name = imagePath.lastPathComponent
        let photo = PickerModel(image: imageData, imageName: name)
        selectedImage.send(photo)
        pickerController.dismiss(animated: true)
    }
}
