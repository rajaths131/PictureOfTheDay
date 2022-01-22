//
//  WebAPIServiceTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 22/01/22.
//

import XCTest
@testable import PictureOfTheDay

class WebAPIServiceTests: XCTestCase {
    
    var apiService: WebAPIService?

    override func tearDownWithError() throws {
        apiService = nil
    }

    func test_fetchPictureOfTheDay_success() throws {
        apiService = WebAPIService()
        let fetchPromise = expectation(description: "fetch")
        apiService?.fetchPictureOfTheDay(completion: { picture, error in
            fetchPromise.fulfill()
            
            XCTAssertNotNil(picture, "Parsing Should not fail")
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func test_fetchPictureOfTheDay_failure() throws {
        let config = APIConfig(endPoint: "https://testing", defaultParam: [:])
        apiService = WebAPIService(config: config)
        let fetchPromise = expectation(description: "fetch")
        apiService?.fetchPictureOfTheDay(completion: { picture, error in
            fetchPromise.fulfill()
            
            XCTAssertNotNil(error, "It should fail with error")
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func test_fetchPictureOfTheDay_InvalidRequest() throws {
        let config = APIConfig(endPoint: "te#$^^sting", defaultParam: [:])
        apiService = WebAPIService(config: config)
        let fetchPromise = expectation(description: "fetch")
        apiService?.fetchPictureOfTheDay(completion: { picture, error in
            fetchPromise.fulfill()
            
            XCTAssertNotNil(error, "It should fail with error")
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}
