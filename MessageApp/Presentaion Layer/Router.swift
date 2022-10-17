//
//  Router.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IRouter{
    func initialViewController()
    func presentMessages(chatID: String, chatName: String)
    func presentProfile()
    func popViewController()
    func presentThemesScreen()
}

struct Router: IRouter {
    
    let navigationController: UINavigationController
    let assemblyBuilder: IViewControllersFactory
    
    func initialViewController() {
        let conversationListViewController = assemblyBuilder.createConversationListModule(router: self)
        navigationController.viewControllers = [conversationListViewController]
    }
    
    func presentMessages(chatID: String, chatName: String) {
        let conversationViewController = assemblyBuilder.createMessagesModule(chatName: chatName,
                                                                              chatId: chatID,
                                                                              router: self)
        navigationController.pushViewController(conversationViewController, animated: true)
    }
    
    func presentProfile() {
        let profileViewController = assemblyBuilder.createProfileModule(router: self)
        guard let previousVC = navigationController.viewControllers.last else { return }
        previousVC.present(profileViewController, animated: true)
    }
    
    func presentThemesScreen() {
        let themesViewController = assemblyBuilder.createThemesModule(router: self)
        navigationController.pushViewController(themesViewController, animated: true)
    }
    
    func popViewController() {
        navigationController.popViewController(animated: true)
    }
}
