//
//  Temperature.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import SwiftyJSON

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
        
        var otherScale: Scale {
            return self == .celsius ? .farenheit : .celsius
        }
    }
    
    /// Hour initializer
    init(fromJSON json: JSON) {
        // Parse the temperatures
        normal[.celsius] = json["tempC"].string
        normal[.farenheit] = json["tempF"].string
        
        // Parse the feels like temperatures
        feel[.celsius] = json["FeelsLikeC"].string
        feel[.farenheit] = json["FeelsLikeF"].string
    }
}
