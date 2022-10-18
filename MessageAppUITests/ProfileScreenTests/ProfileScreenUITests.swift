//
//  MessageAppUITests.swift
//  MessageAppUITests
//
//  Created by Macbook on 18.10.2022.
//

import XCTest

final class ProfileScreenUITests: XCTestCase {
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }
    
    func testProfileScreenElements() {
        let app = XCUIApplication()
        app.launch()
        app.navigationBars["Message App"].buttons["profileButton"].tap()
        
        XCTAssertTrue(app.otherElements["profileView"].waitForExistence(timeout: 5))
        
        XCTAssertTrue(app.images["profileImageView"].exists)
        XCTAssertTrue(app.buttons["editButton"].exists)
        XCTAssertTrue(app.textFields["nameTextField"].exists)
        XCTAssertTrue(app.textFields["bioTextField"].exists)
        XCTAssertTrue(app.textFields["locationTextField"].exists)
        
        app.buttons["editButton"].tap()
        
        XCTAssertTrue(app.images["profileImageView"].exists)
        XCTAssertTrue(app.textFields["nameTextField"].exists)
        XCTAssertTrue(app.textFields["bioTextField"].exists)
        XCTAssertTrue(app.textFields["locationTextField"].exists)
        XCTAssertTrue(app.buttons["saveButton"].exists)
        XCTAssertTrue(app.buttons["cancelButton"].exists)
    }
}
