//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit

final class ConversationListViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero)
    
    private lazy var profileView = ProfileView(frame: .zero, vc: self)
    
    private let conversationCellModel = ConversationCellModel()
    
    private lazy var profileButton = UIBarButtonItem(image: UIImage(systemName: "person.circle"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(showProfile))
    
    
    private lazy var settingsButton = UIBarButtonItem(image: UIImage(systemName: "gear"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(showSettings))
    
    private var onlineCells: [ConversationCell] = []
    private var offlineCells: [ConversationCell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Message App"
        navigationItem.rightBarButtonItem = profileButton
        navigationItem.leftBarButtonItem = settingsButton
        
        addSubviews()
        setupConstraints()
        setupTableView()
        setUpCells()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .gray
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
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupTableView() {
        tableView.register(ConversationListTableViewCell.self, forCellReuseIdentifier: String(describing: ConversationListTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
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
}

//MARK: - UITableViewDataSource

extension ConversationListViewController: UITableViewDataSource {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationListTableViewCell.self)) as? ConversationListTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        if indexPath.section == 0 {
            cell.set(data: onlineCells[indexPath.row])
        } else {
            cell.set(data: offlineCells[indexPath.row])
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConversationViewController()
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
