//
//  ViewController.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit

class LibraryViewController: UIViewController {
    let libraryView = LibraryView(frame: .zero)
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        Task {
            let photoTypes = try await networkService.getPhotoTypesRequest(page: 0)
            libraryView.content = photoTypes.content
            libraryView.reloadPhotos()
        }
    }
    
    func setupView() {
        view.addSubview(libraryView)
        libraryView.frame = self.view.bounds
        libraryView.backgroundColor = .blue
    }
}

