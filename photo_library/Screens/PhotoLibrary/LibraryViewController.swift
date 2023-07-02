//
//  ViewController.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine

class LibraryViewController: UIViewController {
    let viewModel = LibraryViewModel()
    let libraryView = LibraryView(frame: .zero)
    var subscriber = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addObservers()
    }
    
    private func addObservers() {
        subscribeOnParseContent()
        subscribeOnlastSection()
    }
    
    private func subscribeOnParseContent() {
        viewModel.content
            .sink { [weak self] content in
                self?.libraryView.appendNew(content: content)
            }
            .store(in: &subscriber)
    }
    
    private func subscribeOnlastSection() {
        libraryView.lastPage
            .sink { _ in
                self.viewModel.loadNextPage()
            }
            .store(in: &subscriber)
    }

    private func setupView() {
        view.addSubview(libraryView)
        libraryView.frame = self.view.bounds
        libraryView.backgroundColor = .blue
    }
}

