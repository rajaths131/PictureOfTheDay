//
//  Picture.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 22/01/22.
//

import Foundation

class Picture: Codable {
    var copyright: String
    var date: String
    var explanation: String
    var hdurl: String
    var mediaType: String
    var serviceVersion: String
    var title: String
    var url: String
}
