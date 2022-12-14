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
            reference.document(documentId).collection("messages").order(by: Constants.Messages.created).addSnapshotListener { snapshot, error in
                guard let snapshot = snapshot else {
                    guard let err = error else { return }
                    completion(.failure(err))
                    return
                }
                var messages: [Message] = []
                snapshot.documents.forEach { document in
                    guard let message = Message(document: document) else {return}
                    messages.append(message)
                }
                completion(.success(messages))
            }
        }
    }
    
    private func loadDocumentID(completion: @escaping (String) -> Void) {
        reference.getDocuments { snapshot, error in
            if let error = error {
                Logger.shared.message(error.localizedDescription)
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
