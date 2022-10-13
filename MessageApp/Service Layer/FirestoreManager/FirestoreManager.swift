//
//  FirestoreManager.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit
import FirebaseFirestore

protocol IFirestoreManager {
    func saveChannel(name: String)
    func saveMessage(chatId: String, message: String, senderName: String)
}

struct FirestoreManager: IFirestoreManager {
    
    private let reference = Firestore.firestore().collection("channels")
    
    func saveChannel(name: String) {
        let idCreator = IDCreator()
        let identifier = idCreator.createID(length: 10)
        let lastActivity = Date()
        reference.addDocument(data: [
            Constants.Channels.identifier: identifier,
            Constants.Channels.name: name,
            Constants.Channels.lastMessage: "No messages yet",
            Constants.Channels.lastActivity: lastActivity
        ])
    }
    
    func saveMessage(chatId: String, message: String, senderName: String) {
        reference.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else {return}
            documents.forEach {
                let data = $0.data()
                let identifier = data[Constants.Channels.identifier] as? String
                if identifier == chatId {
                    let created = Date()
                    let senderId = UIDevice.current.identifierForVendor?.uuidString
                    reference.document($0.documentID).collection("messages").addDocument(data: [
                        Constants.Messages.content: message,
                        Constants.Messages.created: created,
                        Constants.Messages.senderId: senderId ?? "",
                        Constants.Messages.senderName: senderName
                    ])
                }
            }
        }
    }
}
