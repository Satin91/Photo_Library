//
//  LibraryTableViewCell.swift
//  photo_library
//
//  Created by Артур Кулик on 02.07.2023.
//

import UIKit

class LibraryTableViewCell: UITableViewCell {
    var photoImageView: UIImageView?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, id: Int, image: UIImage?) {
        var content = self.defaultContentConfiguration()
        content.text = name
        content.secondaryText = String(id)
        content.imageProperties.maximumSize = CGSize(width: 60, height: 60)
        content.imageProperties.cornerRadius = 2
        let photoImage = image ?? UIImage(named: "placeholder")
        content.image = photoImage
        self.contentConfiguration = content
    }
}
