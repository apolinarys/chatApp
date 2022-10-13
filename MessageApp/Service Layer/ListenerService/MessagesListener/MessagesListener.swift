//
//  MessagesListener.swift
//  MessageApp
//
//  Created by Macbook on 11.10.2022.
//

import UIKit
import FirebaseFirestore

protocol IMessagesListener {
    func addMessagesListener(completion: @escaping (Result<[Message], Error>) -> Void)
}

struct MessagesListener: IMessagesListener {
    
    let chatId: String
    
    private let reference = Firestore.firestore().collection("channels")
    
    func addMessagesListener(completion: @escaping (Result<[Message], Error>) -> Void) {
        loadDocumentID { documentId in
            reference.document(documentId).collection("messages").addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    guard let err = error else { return }
                    completion(.failure(err))
                    return
                }
                snapshot.documentChanges.forEach { changes in
                    guard let message = Message(document: changes.document) else {return}
                    completion(.success([message]))
                }
            }
        }
    }
    
    private func loadDocumentID(completion: @escaping (String) -> Void) {
        reference.getDocuments { snapshot, error in
            if let error = error {
                print("There was an issue reading data from Firestore, \(error)")
            }
            guard let documents = snapshot?.documents else {
                return
            }
            documents.forEach {
                let data = $0.data()
                let identifier = data[Constants.Channels.identifier] as? String
                if identifier == chatId {
                    completion($0.documentID)
                }
            }
        }
    }
}
