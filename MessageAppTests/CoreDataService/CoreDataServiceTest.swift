//
//  CoreDataServiceTest.swift
//  MessageAppTests
//
//  Created by Macbook on 18.10.2022.
//

import XCTest
@testable import MessageApp

final class CoreDataServiceTest: XCTestCase {
    
    // MARK: - Dependencies
    
    private var coreDataStack: CoreDataStackMock!
    
    private var coreDataService: CoreDataService!
    
    // MARK: - XCTestCase
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        coreDataStack = CoreDataStackMock()
        
        coreDataService = CoreDataService(coreDataStack: coreDataStack)
    }
    
    override func tearDown() {
        super.tearDown()
        
        coreDataStack = nil
        
        coreDataService = nil
    }
    
    // MARK: - Tests
    
    func test_coreDataService_saveChannel() {
        // given
        let channel = Channel(identifier: "", name: "", lastMessage: nil, lastActivity: nil)
        
        // when
        coreDataService.saveChannel(channel: [channel])
        
        // then
        XCTAssertTrue(coreDataStack.invokedPerformSave)
        XCTAssertEqual(coreDataStack.invokedPerformSaveCount, 1)
    }
    
    func test_coreDataService_getChannels() {
        // when
        let _ = coreDataService.getChannels()
        
        // then
        XCTAssertTrue(coreDataStack.invokedFetch)
        XCTAssertEqual(coreDataStack.invokedFetchCount, 1)
    }
}
