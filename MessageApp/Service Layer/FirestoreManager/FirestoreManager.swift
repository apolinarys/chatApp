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
}
