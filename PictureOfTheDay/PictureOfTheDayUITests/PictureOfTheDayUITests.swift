//
//  PictureOfTheDayUITests.swift
//  PictureOfTheDayUITests
//
//  Created by Rajath Shetty on 22/01/22.
//

import XCTest

class PictureOfTheDayUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_TitleAndDiscriptionAndImageAvailable() throws {
        let app = XCUIApplication()
        app.launch()
        
        let element = app.images["ImageView"]
        let existsPredicate = NSPredicate(format: "exists == true")
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(app.staticTexts["TitleLabel"].exists)
        XCTAssertTrue(app.staticTexts["DiscriptionLabel"].exists)
    }

    func test_hidding_titleAndDiscription() throws {
        let app = XCUIApplication()
        app.launch()

        app.buttons["AnimationButton"].tap()

        XCTAssertFalse(app.otherElements["HeaderView"].exists)
        XCTAssertFalse(app.otherElements["DiscriptionView"].exists)
        
        app.buttons["AnimationButton"].tap()
        
        XCTAssertTrue(app.otherElements["HeaderView"].exists)
        XCTAssertTrue(app.otherElements["DiscriptionView"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
