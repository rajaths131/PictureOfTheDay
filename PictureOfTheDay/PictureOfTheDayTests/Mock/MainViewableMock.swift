//
//  MainViewableMock.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 23/01/22.
//

import XCTest
@testable import PictureOfTheDay

class MainViewableMock: MainViewable {
    var showLoadingIndicatorCalled = false
    var hideLoadingIndicatorAndShowNoDataErrorCalled = false
    var hideLoadingIndicatorCalled = false
    var showDetailsCalled = false
    var title: String?
    var details: String?
    var isPastImage: Bool?
    var hideLoadingIndicatorAndShowImageCalled = false
    var image: UIImage?
    var hideLoadingIndicatorAndShowNoImageErrorCalled = false
    
    func showLoadingIndicator() {
        showLoadingIndicatorCalled = true
    }
    
    func hideLoadingIndicatorAndShowNoDataError() {
        hideLoadingIndicatorAndShowNoDataErrorCalled = true
    }
    
    func hideLoadingIndicator() {
        hideLoadingIndicatorCalled = true
    }
    
    func showDetails(title: String, details: String, isPastImage: Bool) {
        showDetailsCalled = true
        self.title = title
        self.details = details
        self.isPastImage = isPastImage
    }
    
    func hideLoadingIndicatorAndShowImage(_ image: UIImage) {
        hideLoadingIndicatorAndShowImageCalled = true
        self.image = image
    }
    
    func hideLoadingIndicatorAndShowNoImageError() {
        hideLoadingIndicatorAndShowNoImageErrorCalled = true
    }

}

