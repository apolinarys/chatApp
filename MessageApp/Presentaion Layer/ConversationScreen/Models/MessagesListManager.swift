//
//  MessagesListManager.swift
//  MessageApp
//
//  Created by Macbook on 07.10.2022.
//

import UIKit
import FirebaseFirestore

struct Message {
    let content: String
    let created: Date
    let senderId: String
    let senderName: String
}

struct MessagesListManager {
    
    private let reference = Firestore.firestore().collection("channels")
    
    func loadMessages(chatId: String, completion: @escaping ([Message]) -> Void) {
        var messages: [Message] = []
        reference.getDocuments { snapshot, error in
            if let error = error {
                print("There was an issue reading data from Firestore, \(error)")
            } else {
                if let documents = snapshot?.documents {
                    documents.forEach {
                        let data = $0.data()
                        let identifier = data[Constants.Channels.identifier] as? String
                        if identifier == chatId {
                            self.reference.document($0.documentID).collection("messages").addSnapshotListener { snapshot, error in
                                if let error = error {
                                    print("There was an issue reading messages data from Firestore, \(error)")
                                } else {
                                    messages = []
                                    if let documents = snapshot?.documents {
                                        documents.forEach {
                                            let data = $0.data()
                                            let content = data[Constants.Messages.content] as? String
                                            let created = data[Constants.Messages.created] as? Timestamp
                                            let senderId = data[Constants.Messages.senderId] as? String
                                            let senderName = data[Constants.Messages.senderName] as? String
                                            let date = created?.dateValue()
                                            if let content = content, let date = date, let senderId = senderId, let senderName = senderName {
                                                messages.append(Message(content: content,
                                                                        created: date,
                                                                        senderId: senderId,
                                                                        senderName: senderName))
                                            }
                                        }
                                        print(messages)
                                        completion(messages)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func addMessage(content: String, created: Date, senderId: String, senderName: String, chatId: String) {
        reference.getDocuments { snapshot, error in
            if let error = error {
                print("There was an issue reading data from Firestore, \(error)")
            } else {
                if let documents = snapshot?.documents {
                    documents.forEach {
                        let data = $0.data()
                        let identifier = data[Constants.Channels.identifier] as? String
                        if identifier == chatId {
                            reference.document($0.documentID).collection("messages").addDocument(data: [
                                Constants.Messages.content: content,
                                Constants.Messages.created: created,
                                Constants.Messages.senderId: senderId,
                                Constants.Messages.senderName: senderName
                            ])
                        }
                    }
                }
            }
        }
    }
}
