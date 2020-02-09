//
//  VisualValidationTests.swift
//  DecoupledNetworkingUITests
//
//  Created by Alex on 09/02/2020.
//  Copyright © 2020 tonezone6. All rights reserved.
//

import XCTest

class VisualValidationTests: XCTestCase {

    func testCellVisuals() {
        let app = XCUIApplication()
        
        XCTContext.runActivity(named: "Launch the app") { _ in
            app.launch()
        }
        
        XCTContext.runActivity(named: "Gather screenshots") { activity in
            // Fullscreen
            let mainScreen = XCUIScreen.main
            let screenshot = mainScreen.screenshot()
            let attachment = XCTAttachment(screenshot: screenshot)
            attachment.lifetime = .keepAlways
            activity.add(attachment)
            
            // Cell
            let cell = app.cells.element(boundBy: 0)
            let cellScreenshot = cell.screenshot()
            let cellAttachment = XCTAttachment(screenshot: cellScreenshot)
            cellAttachment.lifetime = .keepAlways
            activity.add(cellAttachment)
            
            app.terminate()
        }
    }

}
