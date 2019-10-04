//
//  WeatherDay.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation

typealias WeatherDays = [WeatherDay]

struct WeatherDay {
    var date: Date
    var hourlyWeather: [HourlyWeather]
}
