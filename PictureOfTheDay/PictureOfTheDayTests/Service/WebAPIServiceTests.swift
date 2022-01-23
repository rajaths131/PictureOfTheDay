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
        apiService?.fetchPictureOfTheDay(completion: { result in
            fetchPromise.fulfill()
            
            switch result {
            case .success(_):
                XCTAssertTrue(true)

            case .failure(_):
                XCTAssertTrue(false)
            }
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func test_fetchPictureOfTheDay_failure() throws {
        let config = APIConfig(endPoint: "https://testing", defaultParam: [:])
        apiService = WebAPIService(config: config)
        let fetchPromise = expectation(description: "fetch")
        apiService?.fetchPictureOfTheDay(completion: { result in
            fetchPromise.fulfill()
            
            switch result {
            case .success(_):
                XCTAssertTrue(false)

            case .failure(_):
                XCTAssertTrue(true)
            }
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
    
    func test_fetchPictureOfTheDay_InvalidRequest() throws {
        let config = APIConfig(endPoint: "te#$^^sting", defaultParam: [:])
        apiService = WebAPIService(config: config)
        let fetchPromise = expectation(description: "fetch")
        apiService?.fetchPictureOfTheDay(completion: { result in
            fetchPromise.fulfill()
            
            switch result {
            case .success(_):
                XCTAssertTrue(false)

            case .failure(_):
                XCTAssertTrue(true)
            }
        })
        
        waitForExpectations(timeout: 60, handler: nil)
    }
}
