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
    var mockDownloadService: DownloadServiceMock?
    var mockAPiService: WebAPIServiceMock?

    override func setUpWithError() throws {
        UserDefaults.standard.removeObject(forKey: DataFetchInteracter.Constants.dataKey)
        mockDownloadService = DownloadServiceMock()
        mockAPiService = WebAPIServiceMock()
        interacter = DataFetchInteracter(apiService: mockAPiService!,
                                         downloadService: mockDownloadService!)
        mockView = MainViewableMock()
        presenter = MainViewPresenter(view: mockView!,
                                      interacter: interacter!)
    }

    override func tearDownWithError() throws {
        interacter = nil
        mockView = nil
        presenter = nil
        mockDownloadService = nil
        mockAPiService = nil
    }

    func test_mainViewLoaded() throws {
        presenter?.mainViewLoaded()
        
        XCTAssertTrue(mockView?.showLoadingIndicatorCalled == true)
    }
    
    func test_mainViewLoaded_failure() throws {

        let fetchPromise = expectation(description: "error")
        mockView?.triggerPoint = {
            fetchPromise.fulfill()
        }
        
        presenter?.mainViewLoaded()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(mockView?.hideLoadingIndicatorAndShowNoDataErrorCalled == true)

    }
    
    func test_mainViewLoaded_success() throws {
        let path: String! = Bundle(for: type(of: self))
            .path(forResource: "PictureOfTheDay", ofType: "json")
        let url: URL = URL(fileURLWithPath: path)
        let data: Data! = try? Data(contentsOf: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        mockAPiService?.picture = try? decoder.decode(Picture.self, from: data)

        let fetchPromise = expectation(description: "success")
        mockView?.triggerPoint = {
            fetchPromise.fulfill()
        }
        
        presenter?.mainViewLoaded()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertTrue(mockView?.showDetailsCalled == true)
        XCTAssertEqual(mockView?.title, mockAPiService?.picture?.title)

    }
}
