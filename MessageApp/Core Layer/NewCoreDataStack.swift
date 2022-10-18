//
//  NewCoreDataStack.swift
//  MessageApp
//
//  Created by Macbook on 17.10.2022.
//

import CoreData

protocol ICoreDataStack {
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]?
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void)
}

final class NewCoreDataStack: ICoreDataStack {
    
    private lazy var container: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { _, error in
            if let error = error {
                Logger.shared.message(error.localizedDescription)
            }
        }
        return container
    }()
    
    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]? {
        return try? container.viewContext.fetch(fetchRequest)
    }
    
    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        let context = container.newBackgroundContext()
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
