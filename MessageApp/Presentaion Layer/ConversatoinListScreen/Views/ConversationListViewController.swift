//
//  ConversationListViewController.swift
//  MessageApp
//
//  Created by Macbook on 25.09.2022.
//

import UIKit
import FirebaseFirestore
import CoreData

protocol IConversationView: UIViewController {
    var theme: Theme? {get set}
    func updateUI(channels: [Channel])
}

final class ConversationListViewController: UIViewController, IConversationView {
    
    private let tableView = UITableView(frame: CGRect.zero)
    private var channels: [Channel] = []
    
    var theme: Theme?
    var presenter: IConversationListPresenter?
    private let themeViewController = ThemesViewController()
    private var fetchedResultController: NSFetchedResultsController<DBChannel>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchedResultController = presenter?.setupFetchedResultController()
        fetchedResultController?.delegate = self
        view.backgroundColor = theme?.mainColor
        customizeNavigationBar()
        setUpCells()
        presenter?.onViewDidLoad()
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
        guard let sections = fetchedResultController?.sections else {return 0}
        return sections[section].numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ConversationListTableViewCell.self)) as? ConversationListTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        guard let channel = fetchedResultController?.object(at: indexPath), let identifier = channel.identifier, let name = channel.name
        else {return cell}
        
        cell.configure(data: Channel(identifier: identifier,
                                     name: name,
                                     lastMessage: channel.lastMessage,
                                     lastActivity: channel.lastActivity),
                       theme: theme ?? Theme.Classic)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ConversationListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let channel = fetchedResultController?.object(at: indexPath), let identifier = channel.identifier, let name = channel.name
        else {return}
        presenter?.presentMessages(chatID: identifier, chatName: name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == UITableViewCell.EditingStyle.delete else {return}
        
        let channel = fetchedResultController?.object(at: indexPath)
        guard let channelId = channel?.identifier else {return}
        presenter?.deletChannel(channelId: channelId)
    }

    func updateTheme() {
        theme = ThemeManager.currentTheme()
        tableView.reloadData()
    }
}

//MARK: - UpdateUI

extension ConversationListViewController {
    func updateUI(channels: [Channel]) {
        self.channels = channels
        tableView.reloadData()
    }
}

//MARK: - NSFetchedResultsControllerDelegate

extension ConversationListViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            print("insert")
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.bottom)
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            tableView.insertRows(at: [newIndexPath], with: UITableView.RowAnimation.automatic)
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        @unknown default:
            return
        }
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
