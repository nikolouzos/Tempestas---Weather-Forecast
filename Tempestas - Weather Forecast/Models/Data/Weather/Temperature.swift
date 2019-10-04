//
//  Temperature.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

struct Temperature {
    // Hourly parameters
    var normal: [Scale: String?] = [:]
    var feel: [Scale: String?] = [:]
    
    /// The Scales used by the Temperature (Celsius, Farenheit)
    enum Scale: String {
        case celsius = "Celsius", farenheit = "Farenheit"
        
        var abbreviation: String {
            switch self {
            case .celsius:
                return "C"
            case .farenheit:
                return "F"
            }
        }
    }
    
    /// Hour initializer
    init(fromHourDict dict: [String: Any]) {
        // Parse the temperatures
        normal[.celsius] = dict["tempC"] as? String
        normal[.farenheit] = dict["tempF"] as? String
        
        // Parse the feels like temperatures
        feel[.celsius] = dict["FeelsLikeC"] as? String
        feel[.farenheit] = dict["FeelsLikeF"] as? String
    }
}
