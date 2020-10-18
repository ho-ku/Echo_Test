//
//  MainView.swift
//  Echo_TestApp
//
//  Created by Денис Андриевский on 18.10.2020.
//

import UIKit

protocol MainViewDelegate: class {
    
}

class MainView: UIView {

    // MARK: - IBOutlets
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var tableView: UITableView!
    // MARK: - Propeties
    weak var delegate: (MainViewDelegate & UITableViewDelegate & UITableViewDataSource)? {
        didSet {
            setupDelegates()
        }
    }
    
    func setText(_ text: String) {
        textView.text = text
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func registerCell(for id: String) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: id)
    }
    
    private func setupDelegates() {
        tableView.delegate = delegate
        tableView.dataSource = delegate
    }
}
