//
//  MessagesPresenter.swift
//  MessageApp
//
//  Created by Macbook on 13.10.2022.
//

import UIKit
import CoreData

protocol IMessagesPresenter {
    func sendMessage(message: String)
    func onViewDidLoad()
    func setupFetchedResultController() -> NSFetchedResultsController<DBMessage>
}

final class MessagesPresenter: IMessagesPresenter {
    
    weak var view: IMessageView?
    private let router: IRouter
    private let firestoreManager: IFirestoreManager
    private let messagesListener: IMessagesListener
    private let storageManager: IStorageManager
    private let chatId: String
    private let chatName: String
    private let alertPresenter: AlertPresenter
    private let coreDataService: ICoreDataService
    private var profileData: ProfileData?
    
    init(view: IMessageView,
         router: IRouter,
         firestoreManager: IFirestoreManager,
         messagesListener: IMessagesListener,
         storageManager: IStorageManager,
         chatId: String,
         chatName: String,
         alertPresenter: AlertPresenter,
         coreDataService: ICoreDataService) {
        self.view = view
        self.router = router
        self.firestoreManager = firestoreManager
        self.messagesListener = messagesListener
        self.storageManager = storageManager
        self.chatId = chatId
        self.chatName = chatName
        self.alertPresenter = alertPresenter
        self.coreDataService = coreDataService
    }
    
    func onViewDidLoad() {
        addSnapshotListener()
        view?.updateUI(messages: loadMessages())
        view?.navigationItem.title = chatName
    }
    
    func setupFetchedResultController() -> NSFetchedResultsController<DBMessage> {
        coreDataService.setupMessagesFEtchedResultController()
    }
    
    func sendMessage(message: String) {
        getSenderName { [weak self] profileData in
            guard let senderName = profileData?.name else {
                self?.alertPresenter.showNoProfileInformationAlert(vc: self?.view)
                return
            }
            guard let checkedMessage = self?.checkMessage(text: message) else {return}
            guard let self = self else {return}
            self.firestoreManager.saveMessage(chatId: self.chatId, message: checkedMessage, senderName: senderName)
        }
    }
    
    private func loadMessages() -> [Message] {
        return coreDataService.getMessages()
    }
    
    private func checkMessage(text: String) -> String? {
        let trimmedMessage = text.trimmingCharacters(in: Foundation.CharacterSet.whitespacesAndNewlines)
        if trimmedMessage.isEmpty {
            return nil
        }
        return trimmedMessage
    }
    
    private func addSnapshotListener() {
        messagesListener.addMessagesListener { [weak self] result in
            switch result {
            case .success(let messages):
                self?.view?.updateUI(messages: messages)
                guard let chatId = self?.chatId else {return}
                self?.coreDataService.saveMessage(message: messages, channelId: chatId)
            case .failure(let error):
                Logger.shared.message(error.localizedDescription)
            }
        }
    }
    
    private func getSenderName(completion: @escaping (ProfileData?) -> Void) {
        storageManager.loadData { result in
            switch result {
            case .started:
                Logger.shared.message("started")
            case .finished(let profileData):
                completion(profileData)
            }
        }
    }
}
