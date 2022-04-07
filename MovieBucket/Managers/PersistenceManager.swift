//
//  PersistenceManager.swift
//  MovieBucket
//
//  Created by Olijujuan Green on 6/16/20.
//  Copyright © 2020 Olijujuan Green. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    
    
    
    static func updateWith(favorite: Movie, actionType: PersistenceActionType, completed: @escaping(MBError?) -> Void) {
        retrieveFavorite { favorites, error in
            if let _ = error {
                completed(.unableToFavorite)
                return
            }
            
            guard let favorites = favorites else {
                completed(.unableToFavorite)
                return
            }
            
            do {
                var retrievedFavorites = favorites
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favorite) else {
                        completed(.movieAlreadyInFavorites)
                        return
                    }
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll { $0.title == favorite.title }
                }
                completed(save(favorites: retrievedFavorites))
            }
        }
    }
    
    
    
    
    static func retrieveFavorite(completed: @escaping([Movie]?, MBError?) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed([], nil)
            return
        }
        
        do {
            let decoder     = JSONDecoder()
            let favorites   = try decoder.decode([Movie].self, from: favoritesData)
            completed(favorites, nil)
        } catch  {
            completed(nil, .unableToFavorite)
        }
    }
    
    
    
    
    static func save(favorites: [Movie]) -> MBError? {
        
        do {
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favorites)
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
    
    
    
       
}
