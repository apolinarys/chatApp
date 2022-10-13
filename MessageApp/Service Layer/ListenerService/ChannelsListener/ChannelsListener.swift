//
//  ListenerService.swift
//  MessageApp
//
//  Created by Macbook on 10.10.2022.
//

import UIKit
import FirebaseFirestore

protocol IChannelsListener {
    func addChannelsListener(completion: @escaping (Result<ChannelResult, Error>) -> Void) -> ListenerRegistration? 
}

struct ChannelsListener: IChannelsListener {
    
    private let reference = Firestore.firestore().collection("channels")
    
    func addChannelsListener(completion: @escaping (Result<ChannelResult, Error>) -> Void) -> ListenerRegistration? {
        return reference.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                guard let err = error else { return }
                completion(.failure(err))
                return
            }
            snapshot.documentChanges.forEach { changes in
                guard let channel = Channel(document: changes.document) else {return}
                switch changes.type {
                case DocumentChangeType.added:
                    completion(.success(ChannelResult(resultState: ResultState.added, channels: [channel])))
                case DocumentChangeType.modified:
                    completion(.success(ChannelResult(resultState: ResultState.modified, channels: [channel])))
                case DocumentChangeType.removed:
                    completion(.success(ChannelResult(resultState: ResultState.removed, channels: [channel])))
                }
            }
        }
    }
}
