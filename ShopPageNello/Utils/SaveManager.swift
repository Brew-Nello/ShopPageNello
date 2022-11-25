//
//  SaveManager.swift
//  ShopPageNello
//
//  Created by Nello on 2022/11/25.
//

import Foundation

enum SaveManagerKey {
    case likes
    var stringValue: String {
        switch self {
        case .likes: return "likesKey"
        }
    }
}

class SaveManager {
    static func saveObject(object: Codable, key: SaveManagerKey) {
        let propertyListEncoder = try? PropertyListEncoder().encode(object)
        UserDefaults.standard.set(propertyListEncoder, forKey: key.stringValue)
        UserDefaults.standard.synchronize()
    }
    
    static func loadObject(key: SaveManagerKey) -> Data? {
        if UserDefaults.standard.object(forKey: key.stringValue) != nil {
            if let data = UserDefaults.standard.value(forKey: key.stringValue) as? Data {
                return data
            }
        }
        return nil
    }
}
