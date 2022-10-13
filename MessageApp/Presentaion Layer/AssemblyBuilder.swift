//
//  AssemblyBuilder.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IAssemblyBuilder{
    func createConversationListModule(router: IRouter) -> UIViewController
    func createMessagesModule(channelName: String, channelId: String) -> UIViewController
}

struct AssemblyBuilder: IAssemblyBuilder {
    
    func createConversationListModule(router: IRouter) -> UIViewController {
        let view = ConversationListViewController()
        let firestoreManager = FirestoreManager()
        let listenerService = ChannelsListener()
        let presenter = ConversationListPresenter(view: view,
                                                  firestoreManager: firestoreManager,
                                                  router: router,
                                                  listenerService: listenerService)
        view.presenter = presenter
        return view
    }
    
    func createMessagesModule(channelName: String, channelId: String) -> UIViewController {
        let view = ConversationViewController()
        return view
    }
    
    func createProfileModule(router: IRouter) -> UIViewController {
        let vc = ProfileViewController()
        let storageManager = StorageManager()
        let presenter = ProfilePresenter(vc: vc,
                                         router: router,
                                         storageManager: storageManager)
        vc.presenter = presenter
        return vc
    }
}
