//
//  CoreDataService.swift
//  MessageApp
//
//  Created by Macbook on 17.10.2022.
//

import Foundation
import CoreData

protocol ICoreDataService {
    func getMessages() -> [Message]
    func saveMessage(message: [Message], channelId: String)
    func saveChannel(channel: [Channel])
    func updateChannel(channel: [Channel])
    func getChannels() -> [Channel]
    func setupChannelsFetchedResultController() -> NSFetchedResultsController<DBChannel>
    func deleteChannel(channel: [Channel])
    func setupMessagesFEtchedResultController() -> NSFetchedResultsController<DBMessage>
}

struct CoreDataService: ICoreDataService {
    
    let coreDataStack: ICoreDataStack
    
    func getMessages() -> [Message] {
        let fetchRequest: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        let messages = coreDataStack.fetch(fetchRequest: fetchRequest)
        var output: [Message] = []
        messages?.forEach {
            if let content = $0.content, let created = $0.created, let senderId = $0.senderId, let senderName = $0.senderName {
                output.append(Message(content: content,
                                      created: created,
                                      senderId: senderId,
                                      senderName: senderName))
            }
        }
        return output
    }
    
    func saveMessage(message: [Message], channelId: String) {
        
        message.forEach { message in
            let oldMessage = findMessage(senderId: message.senderId, created: message.created)
            guard oldMessage == nil else {return}
            
            coreDataStack.performSave { context in
                let dbMessage = DBMessage(context: context)
                guard let channel = findChannel(channelId: channelId) else {return}
                dbMessage.content = message.content
                dbMessage.created = message.created
                dbMessage.senderId = message.senderId
                dbMessage.senderName = message.senderName
                channel.addToMessages(dbMessage)
            }
        }
    }
    
    func saveChannel(channel: [Channel]) {
        channel.forEach { channel in
            let oldChannel = findChannel(channelId: channel.identifier)
            guard oldChannel == nil else {return}
            
            coreDataStack.performSave { context in
                let dbChannel = DBChannel(context: context)
                dbChannel.identifier = channel.identifier
                dbChannel.lastActivity = channel.lastActivity
                dbChannel.lastMessage = channel.lastMessage
                dbChannel.name = channel.name
            }
        }
    }
    
    func updateChannel(channel: [Channel]) {
        coreDataStack.performSave { context in
            channel.forEach { channel in
                guard let dbChannel = findChannel(channelId: channel.identifier) else {return}
                dbChannel.lastMessage = channel.lastMessage
                dbChannel.lastActivity = channel.lastActivity
            }
        }
    }
    
    func deleteChannel(channel: [Channel]) {
        coreDataStack.performSave { context in
            channel.forEach { channel in
                guard let dbChannel = findChannel(channelId: channel.identifier) else {return}
                context.delete(dbChannel)
            }
        }
    }
    
    func getChannels() -> [Channel] {
        let fetchRequest: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        let channels = coreDataStack.fetch(fetchRequest: fetchRequest)
        var output: [Channel] = []
        channels?.forEach {
            if let identifier = $0.identifier, let name = $0.name {
                output.append(Channel(identifier: identifier,
                                      name: name,
                                      lastMessage: $0.lastMessage,
                                      lastActivity: $0.lastActivity))
            }
        }
        return output
    }
    
    func setupChannelsFetchedResultController() -> NSFetchedResultsController<DBChannel> {
        let context = coreDataStack.getContext()
        let fetchRequest = DBChannel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(DBChannel.lastActivity), ascending: false)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            Logger.shared.message(error.localizedDescription)
        }
        
        return controller
    }
    
    func setupMessagesFEtchedResultController() -> NSFetchedResultsController<DBMessage> {
        let context = coreDataStack.getContext()
        let fetchRequest = DBMessage.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(DBMessage.created), ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                    managedObjectContext: context,
                                                    sectionNameKeyPath: nil,
                                                    cacheName: nil)
        
        do {
            try controller.performFetch()
        } catch {
            Logger.shared.message(error.localizedDescription)
        }
        
        return controller
    }
    
    private func findChannel(channelId: String) -> DBChannel? {
        let fetchRequest: NSFetchRequest<DBChannel> = DBChannel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "identifier = '\(channelId)'")
        return coreDataStack.fetch(fetchRequest: fetchRequest)?.first
    }
    
    private func findMessage(senderId: String, created: Date) -> DBMessage? {
        let fetchRequest: NSFetchRequest<DBMessage> = DBMessage.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "senderId == %@ AND created == %@",
                                             argumentArray: [senderId, created])
        return coreDataStack.fetch(fetchRequest: fetchRequest)?.first
    }
}
