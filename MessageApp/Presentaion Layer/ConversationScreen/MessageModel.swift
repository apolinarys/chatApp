//
//  MessageModel.swift
//  MessageApp
//
//  Created by Macbook on 13.10.2022.
//

import Foundation
import FirebaseFirestore

struct Message {
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        
        guard let content = data[Constants.Messages.content] as? String,
              let created = data[Constants.Messages.created] as? Timestamp,
                let senderId = data[Constants.Messages.senderId] as? String,
                let senderName = data[Constants.Messages.senderName] as? String
        else {return nil}
        
        self.content = content
        self.created = created.dateValue()
        self.senderId = senderId
        self.senderName = senderName
    }
}
