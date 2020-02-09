//
//  DecoupledNetworkingUITests.swift
//  DecoupledNetworkingUITests
//
//  Created by Alex on 08/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import XCTest

class DecoupledNetworkingUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app = XCUIApplication()
        continueAfterFailure = false
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.terminate()
    }

    func testExample() {
        // UI tests must launch the application that they test.
        app.launch()

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["One"]/*[[".cells.staticTexts[\"One\"]",".staticTexts[\"One\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let commentsButton = app.navigationBars["Details"].buttons["Comments"]
        commentsButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Two"]/*[[".cells.staticTexts[\"Two\"]",".staticTexts[\"Two\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        commentsButton.tap()
    }    
}
