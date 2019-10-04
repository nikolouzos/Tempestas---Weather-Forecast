//
//  City.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 3/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

typealias City = String
typealias Cities = [City]

// Make the CitiesWrapper savable
class CitiesWrapper: Saveable {
    var key: String
    var cities: Cities = []
    
    init(withKey key: String) {
        self.key = key
        
        // Get the cities
        load()
    }
    
    // Convenience init
    init() {
        key = ""
    }
}

// MARK: - Saveable implementation
extension CitiesWrapper {
    func save() {
        UserDefaults.standard.set(cities, forKey: key)
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key)
    }
    
    func load() {
        if let cities = UserDefaults.standard.array(forKey: key) as? Cities {
            self.cities = cities
        }
    }
}
