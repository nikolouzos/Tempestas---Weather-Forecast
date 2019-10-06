//
//  ForecastDayCell.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 6/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

class ForecastDayCell: UICollectionViewCell {
    @IBOutlet weak var forecastDayLabel: UILabel!
    @IBOutlet weak var activeLabel: AnimatableLabel!
    
    /// Sets up the cell with the data supplied
    func setupCell(for day: Int, isSelected: Bool) {
        
        // Create and set the day on the forecastDayLabel
        forecastDayLabel.text = getDayString(for: day)
        
        // Fade the activeLabel in or out. This updates only if needed
        activeLabel.animate(.fade(way: isSelected ? .in : .out))
    }
    
    /// Gets the day string for the forecastDayLabel
    private func getDayString(for day: Int) -> String {
        // Try to return a custom day
        switch day {
        case 0: return "Today"
        case 1: return "Tomorrow"
        default: break
        }
        
        // If the day is not Today or Tomorrow format the date using a DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE d MMM"
        dateFormatter.locale = Locale.current
        
        // Create the date for the cell day
        let date = Date().addingTimeInterval(TimeInterval(86400 * day))
        
        return dateFormatter.string(from: date)
    }
}
