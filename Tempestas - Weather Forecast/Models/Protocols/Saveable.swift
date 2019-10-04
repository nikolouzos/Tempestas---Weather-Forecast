//
//  Saveable.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 3/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

/// A protocol that adds the ability to save and remove an object from the UserDefaults
protocol Saveable {
    
    /// Saves the object to the UserDefaults
    func save(withKey key: String)
    
    /// Removes the object from the UserDefaults
    func remove(fromKey key: String)
}

// MARK: - Saveable Protocol implementation
extension Saveable {
    func save(withKey key: String) {
        UserDefaults.standard.set(self, forKey: key)
    }
    
    func remove(fromKey key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
