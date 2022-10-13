//
//  ChannelModel.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import Foundation
import FirebaseFirestore

struct Channel {
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Date?
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        let lastMessage = data[Constants.Channels.lastMessage] as? String
        let lastActivity = data[Constants.Channels.lastActivity] as? Timestamp
        guard let identifier = data[Constants.Channels.identifier] as? String,
                let name = data[Constants.Channels.name] as? String
        else {return nil}
        
        self.name = name
        self.identifier = identifier
        self.lastActivity = lastActivity?.dateValue()
        self.lastMessage = lastMessage
    }
}
