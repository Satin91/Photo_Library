//
//  LibraryTableViewCell.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    
    func configure(name: String, id: Int, image: UIImage?) {
        var content = self.defaultContentConfiguration()
        content.text = name
        content.secondaryText = String(id)
        content.imageProperties.maximumSize = CGSize(width: 45, height: 45)
        content.imageProperties.cornerRadius = 2
        let photoImage = image ?? UIImage(named: "placeholder")
        content.image = photoImage
        self.contentConfiguration = content
    }
}
