//
//  MainViewPresenterTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 23/01/22.
//

import XCTest
@testable import PictureOfTheDay

class MainViewPresenterTests: XCTestCase {
    
    var presenter: MainViewPresenter?
    var interacter: DataFetchInteracter?
    var mockView: MainViewableMock?

    override func setUpWithError() throws {
        interacter = DataFetchInteracter(apiService: WebAPIServiceMock(),
                                         downloadService: DownloadServiceMock())
        mockView = MainViewableMock()
        presenter = MainViewPresenter(view: mockView!,
                                      interacter: interacter!)
    }

    override func tearDownWithError() throws {
        interacter = nil
        mockView = nil
        presenter = nil
    }

    func test_mainViewLoaded() throws {
        presenter?.mainViewLoaded()
        
        XCTAssertTrue(mockView?.showLoadingIndicatorCalled == true)
    }
    
}
