//
//  HourlyWeather.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import SwiftyJSON

struct HourlyWeather {
    var description: String?
    var time: String?
    var temperature: Temperature
    var weatherCode: WeatherCode?
    
    init(fromJSON json: JSON) {
        // Parse the description
        if let description = json["weatherDesc", 0, "value"].string {
            self.description = description
        }
        
        // Parse the time
        if let time = json["time"].string {
            self.time = time
        }
        
        // Parse and create the Temperature
        temperature = Temperature(fromJSON: json)
        
        // Parse and create the weatherCode
        if let weatherCode = json["weatherCode"].string {
            self.weatherCode = WeatherCode.from(String: weatherCode)
        }
    }
}
