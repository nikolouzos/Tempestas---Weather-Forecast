//
//  City.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 3/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

typealias City = String
typealias Cities = [String]

// Make the Cities savable
extension Cities: Saveable { }
