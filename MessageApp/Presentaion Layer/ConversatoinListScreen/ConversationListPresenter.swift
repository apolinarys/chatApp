//
//  ConversationListPresenter.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit
import FirebaseFirestore
import CoreData

protocol IConversationListPresenter {
    func onViewDidLoad()
    func addNewChannel()
    func presentMessages(chatID: String, chatName: String)
    func presentProfile()
    func presentTemesScreen()
    func deletChannel(channelId: String)
    func setupFetchedResultController() -> NSFetchedResultsController<DBChannel>
}

final class ConversationListPresenter: IConversationListPresenter {
    
    private var listener: ListenerRegistration?
    
    private weak var view: IConversationView?
    private let firestoreManager: IFirestoreManager
    private let router: IRouter
    private let listenerService: IChannelsListener
    private let coreDataService: ICoreDataService
    
    init(view: IConversationView,
         firestoreManager: IFirestoreManager,
         router: IRouter,
         listenerService: IChannelsListener,
         coreDataService: ICoreDataService) {
        self.view = view
        self.firestoreManager = firestoreManager
        self.router = router
        self.listenerService = listenerService
        self.coreDataService = coreDataService
    }
    
    private func addChannelListener() {
        listener = listenerService.addChannelsListener { [weak self] result in
            switch result {
            case .success(let channelResult):
                switch channelResult.resultState {
                case .added:
                    print("saved")
                    self?.coreDataService.saveChannel(channel: channelResult.channels)
                case .modified:
                    self?.coreDataService.updateChannel(channel: channelResult.channels)
                case .removed:
                    self?.coreDataService.deleteChannel(channel: channelResult.channels)
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
    
    func setupFetchedResultController() -> NSFetchedResultsController<DBChannel> {
        coreDataService.setupChannelsFetchedResultController()
    }
    
    func onViewDidLoad() {
        addChannelListener()
        view?.updateUI(channels: loadChannels())
        view?.theme = ThemeManager.currentTheme()
    }
    
    private func loadChannels() -> [Channel] {
        coreDataService.getChannels()
    }
    
    func addNewChannel() {
        let alertPresenter = AlertPresenter()
        alertPresenter.showNewChannelAlert(vc: view) { [weak self] name in
            self?.firestoreManager.saveChannel(name: name)
        }
    }
    
    func deletChannel(channelId: String) {
        firestoreManager.deleteChannel(chatId: channelId)
    }
    
    func presentMessages(chatID: String, chatName: String) {
        router.presentMessages(chatID: chatID, chatName: chatName)
    }
    
    func presentProfile() {
        router.presentProfile()
    }
    
    func presentTemesScreen() {
        router.presentThemesScreen()
    }
}
