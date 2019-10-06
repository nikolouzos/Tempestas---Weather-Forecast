//
//  HourlyWeatherView.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 6/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

class HourlyWeatherView: AnimatableView {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    var time: String?
    var weatherCode: WeatherCode?
    var temperature: Temperature?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Set the corner radius for the hourly view
        cornerRadius = bounds.height / 2
    }
    
    /// Formats the time in 12 hour system
    private func getTime() -> String {
        // Note: Because the API is weird and doesn't give a standard time format, I will do this by hand
        switch time {
        case "0":
            return "12 AM"
        case "600":
            return "6 AM"
        case "1200":
            return "12 PM"
        case "1800":
            return "6 PM"
        default:
            return "Unknown time"
        }
    }
}
