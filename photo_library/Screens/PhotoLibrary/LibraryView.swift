//
//  LibraryView.swift
//  photo_library
//
//  Created by Артур Кулик on 01.07.2023.
//

import UIKit

class LibraryView: UIView {
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setupTableView()
        backgroundColor = .blue
    }
    
    func addSubViews() {
        addSubview(tableView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("Layout subviews")
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LibraryTableViewCell
        cell.configure(text: String(indexPath.row), secondaryText: "Secondary text", image: "photo")
        return cell
    }
    
    
}

class LibraryTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, secondaryText: String, image: String) {
        var content = self.defaultContentConfiguration()
        content.text = text
        content.secondaryText = secondaryText
        content.image = UIImage(systemName: image)
        self.contentConfiguration = content
    }
    
}
