//
//  AssemblyBuilder.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IViewControllersFactory{
    func createConversationListModule(router: IRouter) -> UIViewController
    func createMessagesModule(chatName: String, chatId: String, router: IRouter) -> UIViewController
    func createProfileModule(router: IRouter) -> UIViewController
    func createThemesModule(router: IRouter) -> UIViewController
}

struct ViewControllersFactory: IViewControllersFactory {
    
    func createConversationListModule(router: IRouter) -> UIViewController {
        let view = ConversationListViewController()
        let firestoreManager = FirestoreManager()
        let listenerService = ChannelsListener()
        let coreDataStack = NewCoreDataStack()
        let coreDataService = CoreDataService(coreDataStack: coreDataStack)
        let presenter = ConversationListPresenter(view: view,
                                                  firestoreManager: firestoreManager,
                                                  router: router,
                                                  listenerService: listenerService,
                                                  coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
    func createMessagesModule(chatName: String, chatId: String, router: IRouter) -> UIViewController {
        let view = ConversationViewController()
        let firestoreManager = FirestoreManager()
        let messagesListener = MessagesListener(chatId: chatId)
        let storageManager = StorageManager()
        let alertPresenter = AlertPresenter()
        let coreDataStack = NewCoreDataStack()
        let coreDataService = CoreDataService(coreDataStack: coreDataStack)
        let presenter = MessagesPresenter(view: view,
                                          router: router,
                                          firestoreManager: firestoreManager,
                                          messagesListener: messagesListener,
                                          storageManager: storageManager,
                                          chatId: chatId,
                                          chatName: chatName,
                                          alertPresenter: alertPresenter,
                                          coreDataService: coreDataService)
        view.presenter = presenter
        return view
    }
    
    func createProfileModule(router: IRouter) -> UIViewController {
        let vc = ProfileViewController()
        let storageManager = StorageManager()
        let alertControllerPresenter = AllertControllerPresenter()
        let presenter = ProfilePresenter(vc: vc,
                                         router: router,
                                         storageManager: storageManager,
                                         allertControllerPresenter: alertControllerPresenter)
        vc.presenter = presenter
        return vc
    }
    
    func createThemesModule(router: IRouter) -> UIViewController {
        let view = ThemesViewController()
        let themeManager = ThemeManager.shared
        let presenter = ThemesPresenter(router: router, themeManager: themeManager)
        view.presenter = presenter
        return view
    }
}
