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
    let libraryTableView = LibraryTableView(frame: .zero)
    let picker = ImagePickerManager()
    var subscriber = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addObservers()
    }
    
    /// Добавление всех подписчиков
    private func addObservers() {
        onParseContent()
        onNextPageScroll()
        onError()
        onCellTap()
        onPickImage()
    }
    
    /// Подписка на добавление новых страниц с фотографиями
    private func onParseContent() {
        viewModel.photoTypes
            .sink { content in
                self.libraryTableView.appendNew(content: content)
            }
            .store(in: &subscriber)
    }
    
    /// Подписка на загрузку новой страницы
    private func onNextPageScroll() {
        libraryTableView.lastPage
            .sink { _ in
                self.viewModel.loadNextPage()
            }
            .store(in: &subscriber)
    }
    
    /// Подписка на присутствие ошибки
    private func onError() {
        viewModel.error
            .sink { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            .store(in: &subscriber)
    }
    
    private func onCellTap() {
        libraryTableView.selectedIndex
            .sink { indeces in
                self.viewModel.selectedIndex = indeces
                self.present(self.picker.controller, animated: true)
            }
            .store(in: &subscriber)
    }
    
    private func onPickImage() {
        picker.selectedImage
            .sink { photo in
                self.viewModel.uploadPhoto(photo: photo)
            }
            .store(in: &subscriber)
    }
    
    private func setupView() {
        view.addSubview(libraryTableView)
        libraryTableView.frame = self.view.bounds
    }
}

