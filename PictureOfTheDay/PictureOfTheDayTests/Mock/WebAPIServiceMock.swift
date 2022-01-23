//
//  WebAPIServiceMock.swift
//  PictureOfTheDayTests
//
//  Created by Rajath Shetty on 23/01/22.
//

import XCTest
@testable import PictureOfTheDay

class WebAPIServiceMock: WebAPIService {
    var error: Error?
    var picture: Picture?
    
    override func fetchPictureOfTheDay(completion: ((Result<Picture, Error>) -> Void)?) {
        if let result = error {
            completion?(.failure(result))
            return
        }
        
        if let result = picture {
            completion?(.success(result))
            return
        }
        
        completion?(.failure(APIError.invalidRequest))
    }
}
