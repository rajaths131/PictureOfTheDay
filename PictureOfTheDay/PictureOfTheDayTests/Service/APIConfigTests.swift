//
//  APIConfigTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 22/01/22.
//

import XCTest
@testable import PictureOfTheDay

class APIConfigTests: XCTestCase {
    
    var apiConfig: APIConfig?

    override func setUpWithError() throws {
        apiConfig = APIConfig(endPoint: "https://testing.com",
                              defaultParam: [:])
    }

    override func tearDownWithError() throws {
        apiConfig = nil
    }
    
    func test_request_invalidRequest() throws {
        apiConfig?.path = "fetchPa:::&^th"
        
        let request = apiConfig?.getRequest
        XCTAssertNil(request, "Request should be nil")
    }

    func test_request_withPathOnly() throws {
        apiConfig?.path = "fetchPath"
        
        let request = apiConfig?.getRequest
        XCTAssertNotNil(request, "Request can't be nil")
        
        let path = request?.url?.absoluteString
        XCTAssertTrue(path?.contains("fetchPath") == true)
    }
    
    func test_request_withValidParam() throws {
        apiConfig?.path = "fetchPath"
        apiConfig?.param = ["test": "value"]
        
        let body = apiConfig?.postRequest?.httpBody
        XCTAssertNotNil(body, "Request Body can't be nil")
    }
}
