//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit
import FirebaseFirestore

final class ConversationListViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero)    
    var theme = ThemeManager.currentTheme()
    private var channelListManager = ChannelListManager()
    private var channels: [Channel] = []
    
    private lazy var profileButton = UIBarButtonItem(
        image: UIImage(systemName: "person.circle"),
        style: UIBarButtonItem.Style.plain,
        target: self,
        action: #selector(showProfile))
    
    
    private lazy var settingsButton = UIBarButtonItem(
        image: UIImage(systemName: "gear"),
        style: UIBarButtonItem.Style.plain,
        target: self,
        action: #selector(showSettings))
    
    private lazy var addChannelButton = UIBarButtonItem(
        image: UIImage(systemName: "plus.circle"),
        style: UIBarButtonItem.Style.plain,
        target: self,
        action: #selector(addChannel))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        ThemesViewController.delegate = self
        addSubviews()
        setUpCells()
        channelListManager.delegate = self
        channelListManager.loadChats()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.gray
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
    
    @objc private func addChannel() {
        let alertPresenter = AlertPresenter(vc: self)
        alertPresenter.showNewChannelAlert()
    }
    
    private func setUpCells() {
        setupConstraints()
        setupTableView()
        tableView.reloadData()
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
    
    private func setUpNavigationBar() {
        navigationItem.title = "Message App"
        navigationItem.rightBarButtonItems = [addChannelButton, profileButton]
        navigationItem.leftBarButtonItem = settingsButton
    }
}

//MARK: - UITableViewDataSource

extension ConversationListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationListTableViewCell.self)) as? ConversationListTableViewCell
        guard let cell = cell else {return UITableViewCell()}
            cell.set(data: channels[indexPath.row], theme: theme)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConversationViewController()
        vc.chatId = channels[indexPath.row].identifier
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ConversationListViewController: ThemeViewDelegate {
    func updateTheme() {
        theme = ThemeManager.currentTheme()
        tableView.reloadData()
    }
}

//MARK: - ChannelListManagerDelegate

extension ConversationListViewController: ChannelManagerDelegate {
    func updateUI(channels: [Channel]) {
        self.channels = channels
        tableView.reloadData()
    }
}
