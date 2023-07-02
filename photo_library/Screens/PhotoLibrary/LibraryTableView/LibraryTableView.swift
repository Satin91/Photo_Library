//
//  LibraryTableView.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine

class LibraryTableView: UIView {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var content: [[LibraryPhotoModel]] = []
    var lastPage = PassthroughSubject<Int,Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupTableView()
    }
    
    func appendNew(content: [[LibraryPhotoModel]]) {
        self.content = content
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func reloadPhotos() {
        tableView.reloadData()
    }
    
    private func addSubViews() {
        addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(LibraryTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension LibraryTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        content.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LibraryTableViewCell
        let image = content[indexPath.section][indexPath.row].image
        let name = content[indexPath.section][indexPath.row].name
        let id = content[indexPath.section][indexPath.row].id
        cell.configure(name: name, id: id, image: image)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == content[indexPath.section].count && indexPath.section + 1 == content.count {
            lastPage.send(indexPath.section + 1)
        }
    }
}