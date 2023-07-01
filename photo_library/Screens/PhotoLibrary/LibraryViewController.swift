//
//  ViewController.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit

class LibraryViewController: UIViewController {
    let libraryView = LibraryView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(libraryView)
        libraryView.frame = self.view.bounds
        libraryView.backgroundColor = .blue
    }
}

