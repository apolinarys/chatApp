//
//  CoreDataStackMock.swift
//  MessageAppTests
//
//  Created by Macbook on 18.10.2022.
//

import Foundation
import CoreData
@testable import MessageApp

final class CoreDataStackMock: ICoreDataStack {
    
    var invokedGetContext = false
    var invokedGetContextCount = 0
    var stubbedGetContextResult: NSManagedObjectContext!
    
    func getContext() -> NSManagedObjectContext {
        invokedGetContext = true
        invokedGetContextCount += 1
        return stubbedGetContextResult
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var invokedFetchParameters: (fetchRequest: NSFetchRequest<NSFetchRequestResult>, Void)?
    var invokedFetchParametersList = [(fetchRequest: NSFetchRequest<NSFetchRequestResult>, Void)]()
    var stubbedFetchResult: [Any]!

    func fetch<T>(fetchRequest: NSFetchRequest<T>) -> [T]? {
        invokedFetch = true
        invokedFetchCount += 1
        guard let fetchRequest = fetchRequest as? NSFetchRequest<NSFetchRequestResult> else {return nil}
        invokedFetchParameters = (fetchRequest, ())
        invokedFetchParametersList.append((fetchRequest, ()))
        return stubbedFetchResult as? [T]
    }

    var invokedPerformSave = false
    var invokedPerformSaveCount = 0
    var stubbedPerformSaveBlockResult: (NSManagedObjectContext, Void)?

    func performSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        invokedPerformSave = true
        invokedPerformSaveCount += 1
        if let result = stubbedPerformSaveBlockResult {
            block(result.0)
        }
    }
}
