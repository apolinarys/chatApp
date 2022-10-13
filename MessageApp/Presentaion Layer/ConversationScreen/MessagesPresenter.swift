//
//  MessagesPresenter.swift
//  MessageApp
//
//  Created by Macbook on 13.10.2022.
//

import UIKit

protocol IMessagesPresenter {
    func sendMessage(message: String)
    func onViewDidLoad()
}

class MessagesPresenter: IMessagesPresenter {
    
    weak var view: IMessageView?
    let router: IRouter
    let firestoreManager: IFirestoreManager
    let messagesListener: IMessagesListener
    let storageManager: IStorageManager
    let chatId: String
    let chatName: String
    let alertPresenter: AlertPresenter
    private var profileData: ProfileData?
    
    init(view: IMessageView,
         router: IRouter,
         firestoreManager: IFirestoreManager,
         messagesListener: IMessagesListener,
         storageManager: IStorageManager,
         chatId: String,
         chatName: String,
         alertPresenter: AlertPresenter) {
        self.view = view
        self.router = router
        self.firestoreManager = firestoreManager
        self.messagesListener = messagesListener
        self.storageManager = storageManager
        self.chatId = chatId
        self.chatName = chatName
        self.alertPresenter = alertPresenter
    }
    
    func onViewDidLoad() {
        addSnapshotListener()
        view?.navigationItem.title = chatName
    }
    
    func sendMessage(message: String) {
        getSenderName { [weak self] profileData in
            guard let senderName = profileData?.name else {
                self?.alertPresenter.showNoProfileInformationAlert()
                return
            }
            guard let self = self else {return}
            self.firestoreManager.saveMessage(chatId: self.chatId, message: message, senderName: senderName)
        }
    }
    
    private func addSnapshotListener() {
        messagesListener.addMessagesListener { [weak self] result in
            switch result {
            case .success(let messages):
                print(222)
                self?.view?.updateUI(messages: messages)
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
    
    private func getSenderName(completion: @escaping (ProfileData?) -> Void) {
        storageManager.loadData { result in
            switch result {
            case .started:
                print("started")
            case .finished(let profileData):
                completion(profileData)
            }
        }
    }
}
