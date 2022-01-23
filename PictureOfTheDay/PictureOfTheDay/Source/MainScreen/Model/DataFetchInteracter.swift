//
//  DataFetchInteracter.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 23/01/22.
//

import Foundation
import UIKit

class DataFetchInteracter {
    
    enum Constants {
        static let dataKey = "DataStorageKey"
    }
    
    var apiService: WebAPIService
    var downloadService: DownloadService
    var userDefaults = UserDefaults.standard
    
    init(apiService: WebAPIService = WebAPIService(),
         downloadService: DownloadService = DownloadService()) {
        self.apiService = apiService
        self.downloadService = downloadService
    }
    
    func fetchPictureForTheDay(completion: ((Result<Picture, Error>) -> Void)?) {
        
        self.apiService.fetchPictureOfTheDay { result in
            switch result {
            case .success(let fetchedPicture):
                self.storeLastestPicture(fetchedPicture, completion: completion)

            case .failure(_):
                self.checkForCachedPitcure(completion: completion)
            }
        }
    }
    
    private func checkForCachedPitcure(completion: ((Result<Picture, Error>) -> Void)?) {
        var picture: Picture?
        if let pictureData = userDefaults.data(forKey: Constants.dataKey) {
            picture = try? JSONDecoder().decode(Picture.self, from: pictureData)
        }
        
        guard let parsedPicture = picture else {
            completion?(.failure(APIError.parsingFailed))
            return
        }
        
        completion?(.success(parsedPicture))
    }
    
    private func storeLastestPicture(_ picture: Picture,
                             completion: ((Result<Picture, Error>) -> Void)?) {
        let data = try? JSONEncoder().encode(picture)
        userDefaults.set(data, forKey: Constants.dataKey)
        completion?(.success(picture))
    }
    
    func getImageForPath(_ url: String, completion: ((UIImage?) -> Void)?) {
        self.downloadService.getImageForUrl(url, completion: completion)
    }
}
