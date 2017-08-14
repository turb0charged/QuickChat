//
//  QuickChatUITests.swift
//  QuickChatUITests
//
//  Created by Hector Castillo on 8/10/17.
//  Copyright © 2017 Hector Castillo. All rights reserved.
//

import XCTest

class QuickChatUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let app = XCUIApplication()
        let element = app.otherElements.containing(.navigationBar, identifier:"CHAT WITH US").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        let textField = element.children(matching: .other).element.children(matching: .textField).element
        let collectionViewsQuery = app.collectionViews
        let cell = collectionViewsQuery.children(matching: .cell).element(boundBy: 2)
        let collectionView = element.children(matching: .collectionView).element
        textField.tap()
        textField.typeText("test1\r")
        cell.staticTexts["test1"].exists
        textField.typeText("test2\r")
        textField.typeText("test3\r")
        textField.typeText("test this long string that")
        app.typeText(" will surely wrap and cause some issues\r")
        app.typeText("test3\r")
        
        
        collectionView.swipeUp()
        
        collectionView.swipeDown()
        collectionView.swipeDown()
        collectionView.swipeUp()
    }
    
}
