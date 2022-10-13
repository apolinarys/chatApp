//
//  ConversationListPresenter.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit
import FirebaseFirestore

protocol IConversationListPresenter {
    func onViewDidLoad()
    func addNewChannel()
    func presentMessages(chatID: String, chatName: String)
    func presentProfile()
}

class ConversationListPresenter: IConversationListPresenter {
    
    private var listener: ListenerRegistration?
    
    weak var view: IConversationView?
    let firestoreManager: IFirestoreManager
    let router: IRouter
    let listenerService: IChannelsListener
    
    init(view: IConversationView,
         firestoreManager: IFirestoreManager,
         router: IRouter,
         listenerService: IChannelsListener) {
        self.view = view
        self.firestoreManager = firestoreManager
        self.router = router
        self.listenerService = listenerService
    }
    
    private func addChannelListener() {
        listener = listenerService.addChannelsListener { [weak self] result in
            switch result {
            case .success(let channelResult):
                switch channelResult.resultState {
                case .added:
                    self?.view?.updateUI(channels: channelResult.channels)
                case .modified:
                    return
                case .removed:
                    return
                }
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
    
    func onViewDidLoad() {
        addChannelListener()
        view?.theme = ThemeManager.currentTheme()
    }
    
    func addNewChannel() {
        let alertPresenter = AlertPresenter(vc: view)
        alertPresenter.showNewChannelAlert { [weak self] name in
            self?.firestoreManager.saveChannel(name: name)
        }
    }
    
    func presentMessages(chatID: String, chatName: String) {
        router.presentMessages(chatID: chatID, chatName: chatName)
    }
    
    func presentProfile() {
        router.presentProfile()
    }
}
