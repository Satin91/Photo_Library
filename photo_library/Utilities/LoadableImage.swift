//
//  LoadableImage.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit
extension UIImage {
    convenience init?(urlString: String, placeholder: String) {
        self.init()
        if let url = URL(string: urlString) {
            let data = try? Data(contentsOf: url)
            self.init(data: data!)
        } else {
            self.init(systemName: placeholder)
        }
    }
}
