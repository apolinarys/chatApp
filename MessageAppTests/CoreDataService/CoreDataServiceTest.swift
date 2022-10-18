//
//  CoreDataServiceTest.swift
//  MessageAppTests
//
//  Created by Macbook on 18.10.2022.
//

import XCTest
@testable import MessageApp

final class CoreDataServiceTest: XCTestCase {
    
    private let coreDataStackMock = CoreDataStackMock()
    private let channelMock = Channel(identifier: "", name: "", lastMessage: nil, lastActivity: nil)
    
    func testPerformSaveCalled() {
        
        let service = build()
        
        service.saveChannel(channel: [channelMock])
        
        XCTAssertTrue(coreDataStackMock.invokedPerformSave)
        XCTAssertEqual(coreDataStackMock.invokedPerformSaveCount, 1)
    }
    
    func testFetchCalled() {
        
        let service = build()
        
        let _ = service.getChannels()
        
        XCTAssertTrue(coreDataStackMock.invokedFetch)
        XCTAssertEqual(coreDataStackMock.invokedFetchCount, 1)
    }
    
    private func build() -> CoreDataService {
        return CoreDataService(coreDataStack: coreDataStackMock)
    }
}
