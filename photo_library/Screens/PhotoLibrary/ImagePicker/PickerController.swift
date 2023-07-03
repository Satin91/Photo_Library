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
    
    override init() {
        super.init()
        pickerController.delegate = self
    }
}

extension ImagePickerManager: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
    }
}
