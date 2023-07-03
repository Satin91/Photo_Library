//
//  ViewController.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine

/* Главный и единственный контроллер, который содержит свою функциональную модель,
 список типов фотографий, выбор фотографий, а так же их методы выраженные издателями
 */
class LibraryViewController: UIViewController {
    let viewModel = LibraryViewModel()
    let libraryTableView = LibraryTableView(frame: .zero)
    let imagePicker = ImagePicker()
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
    
    /// Добавление новых страниц с фотографиями
    private func onParseContent() {
        viewModel.photoTypes
            .sink { content in
                self.libraryTableView.appendNew(content: content)
            }
            .store(in: &subscriber)
    }
    
    /// Запрос загрузки новой страницы
    private func onNextPageScroll() {
        libraryTableView.pageChanged
            .sink { _ in
                self.viewModel.loadNextPage()
            }
            .store(in: &subscriber)
    }
    
    /// Вывод ошибки по требованию
    private func onError() {
        viewModel.error
            .sink { error in
                self.showAlert(title: "Error", message: error.localizedDescription)
            }
            .store(in: &subscriber)
    }
    
    /// При нажатии на ячейку
    private func onCellTap() {
        libraryTableView.selectedIndex
            .sink { indeces in
                self.viewModel.selectedIndex = indeces
                self.present(self.imagePicker.controller, animated: true)
            }
            .store(in: &subscriber)
    }
    
    /// При выборе фотографии
    private func onPickImage() {
        imagePicker.selectedImage
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

