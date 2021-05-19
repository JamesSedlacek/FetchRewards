//
//  UserDefaultsManager.swift
//  FetchRewards
//
//  Created by James Sedlacek on 5/19/21.
//

import UIKit

// MARK: - Keys

enum keys: String {
    case Favorites = "Favorites"
}

// MARK: - Manager

struct UserDefaultsManager {
    
    // MARK: - Variables
    
    private static let defaults = UserDefaults()
    
    // MARK: - Getters
    
    public static func getFavorites() -> [Int] {
        return defaults.array(forKey: keys.Favorites.rawValue) as? [Int] ?? []
    }
    
    // MARK: - Updates
    
    public static func update(favorites: [Int]) {
        defaults.setValue(favorites, forKey: keys.Favorites.rawValue)
    }
    
    // MARK: - Appends
    
    public static func append(favoriteID id: Int) {
        var favorites = getFavorites()
        favorites.append(id)
        update(favorites: favorites)
    }
    
    // MARK: - Removes
    
    public static func remove(favoriteID id: Int) {
        var favorites = getFavorites()
        if let index = favorites.firstIndex(of: id) {
            favorites.remove(at: index)
            update(favorites: favorites)
        }
    }
    
    // MARK: - Contains
    
    public static func contains(key: keys, element: Any) -> Bool {
        switch key {
        case .Favorites:
            let favorites = getFavorites()
            guard let safeElement = element as? Int else { return false }
            return favorites.contains(safeElement)
        }
    }
}
