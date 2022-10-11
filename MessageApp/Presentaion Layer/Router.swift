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
}
