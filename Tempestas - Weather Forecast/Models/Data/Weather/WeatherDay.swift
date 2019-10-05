//
//  WeatherDay.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias WeatherDays = [WeatherDay]

struct WeatherDay {
    var date: Date?
    var hourlyWeather: [HourlyWeather]
    
    init(fromJSON json: JSON) {
        // Parse the date string to create the Dates
        if let dateString = json["date"].string {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            // Create and assign the date
            let thisDate = dateFormatter.date(from: dateString)
            self.date = thisDate
        }
        
        // Clear the hourlyWeather array
        hourlyWeather = []
        
        // Get the hourly weather array and create the containing objects
        if let hourlyWeatherJsonArray = json["hourly"].array {
            for hourlyWeatherJson in hourlyWeatherJsonArray {
                
                // Create and append the HourlyWeather
                hourlyWeather.append(HourlyWeather(fromJSON: hourlyWeatherJson))
            }
        }
    }
}
