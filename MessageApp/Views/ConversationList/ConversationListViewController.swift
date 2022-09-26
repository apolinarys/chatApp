//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit

final class ConversationListViewController: UIViewController {
    
    private lazy var conversationTableView = UITableView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .green
        title = "Message App"
        setupTableView()
        
        conversationTableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: ConversationListTableViewCell.reuseId)
        conversationTableView.delegate = self
        conversationTableView.dataSource = self
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ConversationListTableViewCell.reuseId) as! ConversationListTableViewCell
        return cell
    }
}
