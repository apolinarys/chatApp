//
//  ConversationViewController.swift
//  MessageApp
//
//  Created by Macbook on 26.09.2022.
//

import UIKit

final class ConversationViewController: UIViewController {
    
    private lazy var tableView = UITableView(frame: .zero)
    
    private var cells: [MessageCell] = []
    
    private let messageCellModel = MessageCellModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        // Do any additional setup after loading the view.
        
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: ConversationTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        cells = messageCellModel.createCells()
        tableView.reloadData()
        tableView.separatorStyle = .none
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationTableViewCell.reuseIdentifier) as! ConversationTableViewCell
        cell.set(data: cells[indexPath.row])
        return cell
    }
}
