//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit

final class ConversationListViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero)
    
    private let profileView = ProfileView()
    
    private let conversationCellModel = ConversationCellModel()
    
    private var onlineCells: [ConversationCell] = []
    private var offlineCells: [ConversationCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            navigationItem.title = "Message App"
        let profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(showProfile))
        self.navigationItem.rightBarButtonItem = profileButton
        
        let settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                            style: .plain,
                                            target: self,
                                            action: #selector(showSettings))
        navigationItem.leftBarButtonItem = settingsButton
        
        setupTableView()
        
        tableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: ConversationListTableViewCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        setUpCells()
        tableView.reloadData()
    }
    
    @objc private func showProfile() {
        let profileVC = ProfileViewController()
        present(profileVC, animated: true)
    }
    
    @objc private func showSettings() {
        let settingsVC = ThemesViewController()
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    private func setUpCells() {
        conversationCellModel.createCells().forEach {
            if $0.online {
                onlineCells.append($0)
            } else {
                offlineCells.append($0)
            }
        }
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConversationViewController()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
