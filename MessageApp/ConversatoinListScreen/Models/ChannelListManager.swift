//
//  ChanelListManager.swift
//  MessageApp
//
//  Created by Macbook on 06.10.2022.
//

import UIKit
import FirebaseFirestore

struct Channel {
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Date?
}

struct ChannelListManager {
    
    private let reference = Firestore.firestore().collection("channels")
    
    func loadChats(completion: @escaping ([Channel]) -> Void) {
        var channels: [Channel] = []
        reference.addSnapshotListener { snapshot, error in
            if let e = error {
                print("There was an issue reading data from Firestore, \(e)")
            } else {
                channels = []
                if let snapshotDocuments = snapshot?.documents {
                    snapshotDocuments.forEach {
                        let data = $0.data()
                        let identifier = data[Constants.Channels.identifier] as? String
                        let name = data[Constants.Channels.name] as? String
                        let lastMessage = data[Constants.Channels.lastMessage] as? String
                        let lastActivity = data[Constants.Channels.lastActivity] as? Timestamp
                        let date = lastActivity?.dateValue()
                        if let identifier = identifier, let name = name {
                            channels.append(Channel(identifier: identifier,
                                                    name: name,
                                                    lastMessage: lastMessage,
                                                    lastActivity: date))
                        }
                    }
                    completion(channels)
                }
            }
        }
    }
    
    func addChannel(identifier: String, name: String, lastMessage: String?, lastActivity: Date?) {
        if let lastMessage = lastMessage {
            if let lastActivity = lastActivity {
                reference.addDocument(data: [
                    Constants.Channels.identifier: identifier,
                    Constants.Channels.name: name,
                    Constants.Channels.lastMessage: lastMessage,
                    Constants.Channels.lastActivity: lastActivity
                ]){ error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added with ID: \(reference.document().documentID)")
                    }
                }
            } else {
                reference.addDocument(data: [
                    Constants.Channels.identifier: identifier,
                    Constants.Channels.name: name,
                    Constants.Channels.lastMessage: lastMessage
                ]){ error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added with ID: \(reference.document().documentID)")
                    }
                }
            }
        } else {
            if let lastActivity = lastActivity {
                reference.addDocument(data: [
                    Constants.Channels.identifier: identifier,
                    Constants.Channels.name: name,
                    Constants.Channels.lastActivity: lastActivity
                ])
            } else {
                reference.addDocument(data: [
                    Constants.Channels.identifier: identifier,
                    Constants.Channels.name: name
                ]){ error in
                    if let error = error {
                        print("Error adding document: \(error)")
                    } else {
                        print("Document added with ID: \(reference.document().documentID)")
                    }
                }
            }
        }
    }
}
