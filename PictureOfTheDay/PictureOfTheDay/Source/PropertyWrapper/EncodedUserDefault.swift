//
//  EncodedUserDefault.swift
//  PictureOfTheDay
//
//  Created by Rajath Shetty on 31/01/22.
//

import Foundation

@propertyWrapper struct EncodedUserDefault<Value: Codable> {
    var wrappedValue: Value? {
        get {
            guard let data = storage.data(forKey:key) else { return nil }
            return try? JSONDecoder().decode(Value.self, from: data)
        }
        set {
            guard newValue != nil else {
                storage.removeObject(forKey: key)
                return
            }
            
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key)
        }
    }
    
    private let storage = UserDefaults.standard
    let key: String
}
