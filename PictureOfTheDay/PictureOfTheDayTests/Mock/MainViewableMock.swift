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
    var triggerPoint: (() -> Void)?
    
    func showLoadingIndicator() {
        showLoadingIndicatorCalled = true
    }
    
    func hideLoadingIndicatorAndShowNoDataError() {
        hideLoadingIndicatorAndShowNoDataErrorCalled = true
        triggerPoint?()
    }
    
    func hideLoadingIndicator() {
        hideLoadingIndicatorCalled = true
        triggerPoint?()
    }
    
    func showDetails(title: String, details: String, isPastImage: Bool) {
        showDetailsCalled = true
        self.title = title
        self.details = details
        self.isPastImage = isPastImage
        triggerPoint?()
    }
    
    func hideLoadingIndicatorAndShowImage(_ image: UIImage) {
        hideLoadingIndicatorAndShowImageCalled = true
        self.image = image
        triggerPoint?()
    }
    
    func hideLoadingIndicatorAndShowNoImageError() {
        hideLoadingIndicatorAndShowNoImageErrorCalled = true
        triggerPoint?()
    }

}

