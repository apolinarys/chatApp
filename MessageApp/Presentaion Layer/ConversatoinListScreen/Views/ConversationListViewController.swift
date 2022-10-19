//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit
import FirebaseFirestore

protocol IConversationView: UIViewController {
    var theme: Theme? {get set}
    func updateUI(channels: [Channel])
    func channelDeleted(channel: Channel)
}

final class ConversationListViewController: UIViewController, IConversationView {
    
    private let tableView = UITableView(frame: CGRect.zero)
    private var channels: [Channel] = []
    
    var theme: Theme?
    var presenter: IConversationListPresenter?
    private let themeViewController = ThemesViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.onViewDidLoad()
        view.backgroundColor = theme?.mainColor
        customizeNavigationBar()
        setUpCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = UIColor.gray
        updateTheme()
    }
}

//MARK: - NavigationBar

extension ConversationListViewController {
    
    private func customizeNavigationBar() {
        
        let profileButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(showProfile))
        profileButton.accessibilityIdentifier = "profileButton"
        
        
        let settingsButton = UIBarButtonItem(
            image: UIImage(systemName: "gear"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(showSettings))
        
        let addChannelButton = UIBarButtonItem(
            image: UIImage(systemName: "plus.circle"),
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(addChannel))
        
        navigationItem.title = "Message App"
        navigationItem.rightBarButtonItems = [addChannelButton, profileButton]
        navigationItem.leftBarButtonItem = settingsButton
    }
    
    @objc private func showProfile() {
        presenter?.presentProfile()
    }
    
    @objc private func showSettings() {
        presenter?.presentTemesScreen()
    }
    
    @objc private func addChannel() {
        presenter?.addNewChannel()
    }
    
}

//MARK: - UITableViewDataSource

extension ConversationListViewController: UITableViewDataSource {
    
    private func setUpCells() {
        addSubviews()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationListTableViewCell.self)) as? ConversationListTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        cell.configure(data: channels[indexPath.row], theme: theme ?? Theme.Classic)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentMessages(chatID: channels[indexPath.row].identifier, chatName: channels[indexPath.row].name)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func updateTheme() {
        theme = ThemeManager.currentTheme()
        tableView.reloadData()
    }
}

//MARK: - UpdateUI

extension ConversationListViewController {
    func updateUI(channels: [Channel]) {
        self.channels += channels
        tableView.reloadData()
    }
    
    func channelDeleted(channel: Channel) {
        for i in 0...channels.count - 1 {
            if channels[i].identifier == channel.identifier {
                channels.remove(at: i)
            }
        }
        tableView.reloadData()
    }
}

//MARK: - Constraints

extension ConversationListViewController {
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
