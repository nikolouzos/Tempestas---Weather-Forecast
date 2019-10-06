//
//  WeatherCode.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 5/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

enum WeatherCode {
    case sunny, cloudy, rainy, misty, snowy, none
    
    struct WeatherCodes {
        static let sunny = ["113"]
        
        static let cloudy = ["116", "119", "122"]
        
        static let rainy = ["176", "311", "308", "305", "302", "299", "296",
                            "293", "284", "281", "266", "263", "200", "185"]
        
        static let misty = ["143", "260", "248"]
        static let snowy = ["179", "230", "227", "182", "192"]
    }
    
    /// Creates a WeatherCode from a String supplied
    static func from(String string: String) -> WeatherCode {
        if WeatherCodes.sunny.contains(string) {
            return .sunny
            
        } else if  WeatherCodes.cloudy.contains(string) {
            return .cloudy
            
        } else if  WeatherCodes.rainy.contains(string) {
            return .rainy
            
        } else if  WeatherCodes.misty.contains(string) {
            return .misty
            
        } else if  WeatherCodes.snowy.contains(string) {
            return .snowy
            
        } else {
            return .none
        }
    }
    
    /// Gets the weather icon from the WeatherCode
    var icon: UIImage? {
        switch self {
        case .sunny:
            return #imageLiteral(resourceName: "sunny")
        case .cloudy:
            return #imageLiteral(resourceName: "cloudy")
        case .rainy:
            return #imageLiteral(resourceName: "rainy")
        case .misty:
            return #imageLiteral(resourceName: "foggy")
        case .snowy:
            return #imageLiteral(resourceName: "snowy")
        default:
            return nil
        }
    }
    
    /// Gets the weather icon from the WeatherCode
    var background: UIImage? {
        switch self {
        case .sunny:
            return #imageLiteral(resourceName: "sunny-bg")
        case .cloudy:
            return #imageLiteral(resourceName: "misty-bg")
        case .rainy:
            return #imageLiteral(resourceName: "rainy-bg")
        case .misty:
            return #imageLiteral(resourceName: "misty-bg")
        case .snowy:
            return #imageLiteral(resourceName: "snowy-bg")
        default:
            return nil
        }
    }
}
