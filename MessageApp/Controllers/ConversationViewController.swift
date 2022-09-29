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
        // Do any additional setup after loading the view.
        
        addSubviews()
        setupConstraints()
        setupTableView()
        cells = messageCellModel.createCells()
        tableView.reloadData()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.register(ConversationTableViewCell.self, forCellReuseIdentifier: String(describing: ConversationTableViewCell.self))
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

//MARK: - UITableViewDataSource

extension ConversationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationTableViewCell.self)) as? ConversationTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        cell.set(data: cells[indexPath.row])
        return cell
    }
}
