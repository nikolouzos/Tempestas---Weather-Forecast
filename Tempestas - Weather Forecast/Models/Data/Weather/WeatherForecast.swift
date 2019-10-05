//
//  WeatherForecast.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherForecast {
    var city: City?
    var weatherDays: WeatherDays?
    
    var errorMessage: String?
    
    init(fromJSON json: JSON) {
        
        // Parse the city
        if let city = json["request", 0, "query"].string {
            self.city = city
        }
        
        // Parse the weather forecast days
        weatherDays = WeatherDays()
        
        if let weatherDaysJson = json["weather"].array {
            for dayJSON in weatherDaysJson {
                weatherDays?.append(WeatherDay(fromJSON: dayJSON))
            }
        }
        
        // Parse the error message (if any)
        errorMessage = json["error", 0, "msg"].string
    }
}
