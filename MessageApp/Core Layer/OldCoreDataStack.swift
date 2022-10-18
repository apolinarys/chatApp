//
//  OldCoreDataStack.swift
//  MessageApp
//
//  Created by Macbook on 17.10.2022.
//

import CoreData

final class OldCoreDataStack {
    
    private lazy var managedObjectModel: NSManagedObjectModel? = {
        guard let moduleURL = Bundle.main.url(forResource: "CoreDataModel", withExtension: "momd") else {return nil}
        return NSManagedObjectModel(contentsOf: moduleURL)
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        guard let managedObjectModel = managedObjectModel else {return nil}
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        let fileManager = FileManager.default
        let storeName = "OldCoreData.sqlite"
        
        let documentsDirectoryURL = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory,
                                                  in: FileManager.SearchPathDomainMask.userDomainMask)[0]
        
        let persistentStoreURL = documentsDirectoryURL.appendingPathComponent(storeName)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: persistentStoreURL)
        } catch {
            Logger.shared.message("Error creating persistentStoreCoordinator")
        }
        return coordinator
    }()
    
    private lazy var readContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        return context
    }()
    
    private lazy var writeContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistentStoreCoordinator
        context.mergePolicy = NSOverwriteMergePolicy
        return context
    }()
    
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]? {
        return try? readContext.fetch(fetchRequest)
    }
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = writeContext
        
        context.perform { [weak self] in
            block(context)
            if context.hasChanges {
                do {
                    try self?.performSave(in: context)
                } catch {
                    Logger.shared.message(error.localizedDescription)
                }
            }
        }
    }
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
}
