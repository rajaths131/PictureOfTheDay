//
//  WebAPIService.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 22/01/22.
//

import Foundation

class APIConstants {
    static let apiEndPoint = "https://api.nasa.gov"
    static let defaultParam = ["api_key": "DEMO_KEY"]
}

class WebAPIService {
    
    enum RequestType: String {
        case pictureOfTheDay = "planetary/apod"
    }
    
    let config: APIConfig
    var session: URLSession
    
    init(config: APIConfig = APIConfig(endPoint: APIConstants.apiEndPoint,
                                       defaultParam: APIConstants.defaultParam)) {
        self.config = config
        let urlConfig = URLSessionConfiguration.default
        urlConfig.networkServiceType = .responsiveData
        self.session = URLSession(configuration: urlConfig)
    }
    
    func fetchPictureOfTheDay(completion: ((Result<Picture, Error>) -> Void)?) {
        var fetchConfig = self.config
        fetchConfig.path = RequestType.pictureOfTheDay.rawValue
        
        guard let request = fetchConfig.getRequest else {
            completion?(.failure(APIError.invalidRequest))
            return
        }
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let serverError = error {
                completion?(.failure(serverError))
                return
            }
            
            guard let pictureData = data else {
                completion?(.failure(APIError.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            guard let picture = try? decoder.decode(Picture.self, from: pictureData) else {
                completion?(.failure(APIError.parsingFailed))
                return
            }
            
            completion?(.success(picture))
        }
        
        dataTask.resume()
    }
}
