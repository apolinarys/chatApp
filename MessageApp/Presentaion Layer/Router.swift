//
//  Router.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit

protocol IRouter{
    func initialViewController()
    func presentMessages(channelID: String, channelName: String)
    func presentProfile()
}

struct Router: IRouter {
    
    let navigationController: UINavigationController
    let assemblyBuilder: AssemblyBuilder
    
    func initialViewController() {
        let conversationListViewController = assemblyBuilder.createConversationListModule(router: self)
        navigationController.viewControllers = [conversationListViewController]
    }
    
    func presentMessages(channelID: String, channelName: String) {
        let conversationViewController = assemblyBuilder.createMessagesModule(channelName: channelName,
                                                                              channelId: channelID)
        navigationController.pushViewController(conversationViewController, animated: true)
    }
    
    func presentProfile() {
        let profileViewController = assemblyBuilder.createProfileModule(router: self)
        let previousVC = ConversationListViewController()
        previousVC.present(profileViewController, animated: true)
    }
}
