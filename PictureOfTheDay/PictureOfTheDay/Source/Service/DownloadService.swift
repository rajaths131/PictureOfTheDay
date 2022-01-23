//
//  DownloadService.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 23/01/22.
//

import Foundation
import UIKit

class DownloadService {
    
    enum Constants {
        static let LastStoredImageName = "LastStoredImageName"
    }
    
    private var queue: DispatchQueue
    private var fileManager = FileManager.default
    private var userDefaults = UserDefaults.standard
    private var documentDirectory: URL? { fileManager.urls(for: .documentDirectory, in: .userDomainMask).first }
    
    init(queue: DispatchQueue = DispatchQueue(label: "SerialImageFetchQueue")) {
        self.queue = queue
    }
    
    func getImageForUrl(_ path: String, completion: ((UIImage?) -> Void)?) {
        queue.async { [weak self] in
            
            guard let strongSelf = self else {
                completion?(nil)
                return
            }
            
            guard let url = URL(string: path) else {
                completion?(nil)
                return
            }
            
            let fileName = url.lastPathComponent
            let lastStoredImage = strongSelf.userDefaults.string(forKey: Constants.LastStoredImageName)
            
            guard let fileUrl = strongSelf.documentDirectory?.appendingPathComponent(fileName) else {
                completion?(nil)
                return
            }
            
            guard fileName != lastStoredImage else {
                var image: UIImage? = nil
                if let imageData = try? Data(contentsOf: fileUrl) {
                    image = UIImage(data: imageData)
                }
                completion?(image)
                return
            }
            
            strongSelf.fetchImageForUrl(url,
                                        fileUrl: fileUrl,
                                        lastFileName: lastStoredImage,
                                        completion: completion)
        }
    }
    
    private func fetchImageForUrl(_ url: URL,
                                  fileUrl: URL,
                                  lastFileName: String?,
                                  completion: ((UIImage?) -> Void)?) {
        
        guard let data = try? Data(contentsOf: url) else {
            completion?(nil)
            return
        }
        
        guard let image = UIImage(data: data) else {
            completion?(nil)
            return
        }
        
        try? data.write(to: fileUrl)
        if let lastFile = lastFileName,
           let deleteUrl = documentDirectory?.appendingPathComponent(lastFile) {
            try? fileManager.removeItem(at: deleteUrl)
        }
        
        userDefaults.setValue(url.lastPathComponent, forKey: Constants.LastStoredImageName)
        completion?(image)
    }
}
