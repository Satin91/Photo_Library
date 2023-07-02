//
//  LibraryView.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit
import Combine

class LibraryView: UIView {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    var content: [[Content]] = []
    var lastPage = CurrentValueSubject<Int,Never>(0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupTableView()
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

extension LibraryView: UITableViewDelegate, UITableViewDataSource {
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
        if indexPath.row + 1 == content[indexPath.section].count && lastPage.value == indexPath.section {
            lastPage.value += 1
            print("last page did changed to \(lastPage.value)")
        }
    }
}

class LibraryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(name: String, id: Int, image: String?) {
        var content = self.defaultContentConfiguration()
        content.text = name
        content.secondaryText = String(id)
//        content.image = UIImage(urlString: image ?? "", placeholder: "photo")
        content.image = UIImage(systemName: "photo")
        self.contentConfiguration = content
    }
}
