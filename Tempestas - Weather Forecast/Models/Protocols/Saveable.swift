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
    
    /// Savable key
    var key: String { get set }
    
    /// Saves the object to the UserDefaults
    func save()
    
    /// Loads the object from the UserDefaults
    mutating func load()
    
    /// Removes the object from the UserDefaults
    func delete()
}
