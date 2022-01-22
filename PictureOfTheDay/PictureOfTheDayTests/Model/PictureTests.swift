//
//  PictureTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 22/01/22.
//

import XCTest
@testable import PictureOfTheDay

class PictureTests: XCTestCase {

    func test_Piture_jsonParsing() throws {
        let path: String! = Bundle(for: type(of: self))
            .path(forResource: "PictureOfTheDay", ofType: "json")
        let url: URL = URL(fileURLWithPath: path)
        let data: Data! = try? Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let picture = try? decoder.decode(Picture.self, from: data)
        XCTAssertNotNil(picture, "Parsing Should not fail")
    }

}
