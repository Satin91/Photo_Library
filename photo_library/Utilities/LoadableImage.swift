//
//  LoadableImage.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

//extension UIImage {
//
//    convenience init(urlString: String?, placeholder: String) {
//        let data = try? Data(contentsOf: url)
//        self = UIImage(data: data ?? Data())
//    }
//
//    func fromURL(urlString: String?, placeholder: String) -> UIImage? {
//        guard let urlString = urlString else {
//            return UIImage(systemName: placeholder)
//        }
//        guard let url = URL(string: urlString) else {
//            return UIImage(systemName: placeholder)
//        }
//        let data = try? Data(contentsOf: url)
//        return UIImage(data: data ?? Data())
//    }
//}

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
