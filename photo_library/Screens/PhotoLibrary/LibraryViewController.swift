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
        subscribeOnParseContent()
        subscribeOnNextpage()
        subscribeOnError()
        subscribeToTypeTap()
    }
    
    /// Подписка на добавление новых страниц с фотографиями
    private func subscribeOnParseContent() {
        viewModel.content
            .sink { content in
                self.libraryTableView.appendNew(content: content)
            }
            .store(in: &subscriber)
    }
    
    /// Подписка на загрузку новой страницы
    private func subscribeOnNextpage() {
        libraryTableView.lastPage
            .sink { _ in
                self.viewModel.loadNextPage()
            }
            .store(in: &subscriber)
    }
    
    /// Подписка на присутствие ошибки
    private func subscribeOnError() {
        viewModel.error.sink { error in
            self.showAlert(title: "Error", message: error.localizedDescription)
        }
        .store(in: &subscriber)
    }
    
    private func subscribeToTypeTap() {
        libraryTableView.selectedIndex
            .sink { indeces in
                self.present(self.picker.pickerController, animated: true)
            }
            .store(in: &subscriber)
    }
    
    

    private func setupView() {
        view.addSubview(libraryTableView)
        libraryTableView.frame = self.view.bounds
    }
}

