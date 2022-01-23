//
//  PictureOfTheDayUITestsLaunchTests.swift
//  PictureOfTheDayUITests
//
//  Created by Rajath Shetty on 22/01/22.
//

import XCTest

class PictureOfTheDayUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
