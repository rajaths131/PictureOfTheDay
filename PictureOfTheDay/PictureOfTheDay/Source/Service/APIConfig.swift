//
//  APIConfig.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 22/01/22.
//

import Foundation

typealias ApiParam = [String: String]

struct APIConfig {
    private var endPoint: String
    private var defaultParam: ApiParam
    private var headers = ["Accept": "application/json"]

    var httpMethod: String = "GET"
    var path: String?
    var param: ApiParam?
    
    init(endPoint: String,
         defaultParam: ApiParam) {
        self.endPoint = endPoint
        self.defaultParam = defaultParam
    }
    
    private var fullAPIPath: String {
        var fullPath = endPoint
        if let apiPath = path { fullPath = fullPath + "/" + apiPath }
        
        return fullPath
    }
    
    private var allParam: ApiParam {
        var complateList: [String: String] = defaultParam
        if let requestParam = param {
            for (key, value) in requestParam { complateList[key] = value }
        }
        return complateList
    }
    
    var getRequest: URLRequest? {
        
        guard var urlComponents = URLComponents(string: fullAPIPath) else { return nil }
        urlComponents.queryItems = allParam.map { (key, value) in
            URLQueryItem(name: key, value: value)}
        
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        return urlRequest
    }
    
    var postRequest: URLRequest? {

        guard let url = URL(string: fullAPIPath) else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        
        let data = try? JSONSerialization.data(withJSONObject: allParam, options: [])
        urlRequest.httpBody = data
        
        return urlRequest
    }
}
