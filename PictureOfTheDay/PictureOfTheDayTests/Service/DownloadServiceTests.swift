//
//  DownloadServiceTests.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 23/01/22.
//

import XCTest
@testable import PictureOfTheDay

class DownloadServiceTests: XCTestCase {
    
    var downloadService: DownloadService?
    
    override func setUpWithError() throws {
        let key = DownloadService.Constants.LastStoredImageName
        if let value = UserDefaults.standard.string(forKey: key) {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            if let finalUrl = url?.appendingPathComponent(value) {
                try? manager.removeItem(at: finalUrl)
            }
        }
        
        UserDefaults.standard.setValue(nil, forKey: key)
        
        downloadService = DownloadService(queue: DispatchQueue.main)
    }

    override func tearDownWithError() throws {
        downloadService = nil
        
        let key = DownloadService.Constants.LastStoredImageName
        if let value = UserDefaults.standard.string(forKey: key) {
            let manager = FileManager.default
            let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
            if let finalUrl = url?.appendingPathComponent(value) {
                try? manager.removeItem(at: finalUrl)
            }
        }
        
        UserDefaults.standard.setValue(nil, forKey: key)
    }
    
    func test_getImageForUrl_FetchingValidImageForFirstTime() {
        let fetchPromise = expectation(description: "download")
        let imagePath = "https://apod.nasa.gov/apod/image/2201/IMG_4039copia2_2048.jpg"
        downloadService?.getImageForUrl(imagePath,
                                        completion: { image in
            fetchPromise.fulfill()
            
            XCTAssertNotNil(image)
        })
        waitForExpectations(timeout: 60, handler: nil)
        
        //Second Request
        let secondFetchPromise = expectation(description: "download")
        downloadService?.getImageForUrl(imagePath,
                                        completion: { image in
            secondFetchPromise.fulfill()
            
            XCTAssertNotNil(image)
        })
        waitForExpectations(timeout: 60, handler: nil)
        
        let nextImage = "https://apod.nasa.gov/apod/image/2201/IMG_4039copia2_1024.jpg"
        let nextImagePromise = expectation(description: "download")
        downloadService?.getImageForUrl(nextImage,
                                        completion: { image in
            nextImagePromise.fulfill()
            
            XCTAssertNotNil(image)
        })
        waitForExpectations(timeout: 60, handler: nil)
    }
}
