//
//  ConversationListPresenter.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IConversationListPresenter {
    func onViewDidLoad()
    func addNewChannel()
    func presentMessages(channelID: String, channelName: String)
    func presentProfile()
}

struct ConversationListPresenter: IConversationListPresenter {
    
    weak var view: IConversationView?
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
    
    func addNewChannel() {
        let alertPresenter = AlertPresenter(vc: view)
        alertPresenter.showNewChannelAlert { name in
            firestoreManager.saveChannel(name: name)
        }
    }
    
    func presentMessages(channelID: String, channelName: String) {
        router.presentMessages(channelID: channelID, channelName: channelName)
    }
    
    func presentProfile() {
        router.presentProfile()
    }
}
