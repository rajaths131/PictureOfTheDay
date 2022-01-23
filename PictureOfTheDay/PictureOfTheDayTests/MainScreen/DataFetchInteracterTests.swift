//
//  DataFetchInteracterTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 23/01/22.
//

import XCTest
@testable import PictureOfTheDay

class DataFetchInteracterTests: XCTestCase {
    
    var interacter: DataFetchInteracter?
    var mockDownloadService: DownloadServiceMock?
    var mockAPiService: WebAPIServiceMock?

    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: DataFetchInteracter.Constants.dataKey)
        mockDownloadService = DownloadServiceMock()
        mockAPiService = WebAPIServiceMock()
        interacter = DataFetchInteracter(apiService: mockAPiService!,
                                         downloadService: mockDownloadService!)
    }

    override func tearDownWithError() throws {
        interacter = nil
        mockDownloadService = nil
        mockAPiService = nil
    }

    func test_fetchPictureForTheDay() throws {
        
        interacter?.fetchPictureForTheDay(completion: { result in
            
            switch result {
            case .success(_):
                XCTAssertTrue(false)
                
            case .failure(_):
                XCTAssertTrue(true)
            }
            
        })
    }
}
