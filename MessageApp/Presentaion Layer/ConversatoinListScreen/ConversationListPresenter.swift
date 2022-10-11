//
//  ConversationListPresenter.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IConversationListPresenter {
    func onViewDidLoad()
    func addNewChannel(name: String)
    func presentMessages(channelID: String, channelName: String)
}

struct ConversationListPresenter: IConversationListPresenter {
    
    weak var view: ConversationListViewController?
    let firestoreManager: IFirestoreManager
    let router: IRouter
    let listenerService: IChannelsListener
    
    private func addChannelListener() {
        listenerService.addChannelsListener { result in
            switch result {
            case .success(let channelResult):
                switch channelResult.resultState {
                case .added:
                    view?.updateUI(channels: channelResult.channels)
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
    
    func addNewChannel(name: String) {
        firestoreManager.saveChannel(name: name)
    }
    
    func presentMessages(channelID: String, channelName: String) {
        router.presentMessages(channelID: channelID, channelName: channelName)
    }
}
