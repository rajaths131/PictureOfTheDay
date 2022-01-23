//
//  APIError.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 23/01/22.
//

import Foundation

enum APIError: Error {
    case invalidRequest
    case invalidResponse
    case parsingFailed
}
