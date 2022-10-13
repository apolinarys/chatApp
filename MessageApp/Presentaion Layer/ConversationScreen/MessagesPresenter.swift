//
//  MessagesPresenter.swift
//  MessageApp
//
//  Created by Macbook on 13.10.2022.
//

import UIKit

protocol IMessagesPresenter {
    
}

struct MessagesPresenter: IMessagesPresenter {
    weak var view: IMessageView?
    let router: IRouter
    
    
}
