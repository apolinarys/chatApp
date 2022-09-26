//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit

final class ConversationListViewController: UIViewController {
    
    private lazy var conversationTableView = UITableView(frame: .zero)
    
    private let conversationCellModel = ConversationCellModel()
    
    private var onlineCells: [Cell] = []
    private var offlineCells: [Cell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Message App"
        setupTableView()
        
        conversationTableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: ConversationListTableViewCell.reuseId)
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
        setUpCells()
        conversationTableView.reloadData()
    }
    
    private func setUpCells() {
        for cell in conversationCellModel.createCells() {
            if cell.online {
                onlineCells.append(cell)
            } else {
                offlineCells.append(cell)
            }
        }
    }
    
    private func setupTableView() {
        view.addSubview(conversationTableView)
        conversationTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conversationTableView.topAnchor.constraint(equalTo: view.topAnchor),
            conversationTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conversationTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conversationTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - UITableViewDataSource, UITableViewDelegate

extension ConversationListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return onlineCells.count
        }
        return offlineCells.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationListTableViewCell.reuseId) as! ConversationListTableViewCell
        if indexPath.section == 0 {
            cell.set(data: onlineCells[indexPath.row])
        } else {
            cell.set(data: offlineCells[indexPath.row])
        }
        return cell
    }
}
