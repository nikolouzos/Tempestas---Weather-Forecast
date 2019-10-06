//
//  ForecastVC.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 6/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

class ForecastVC: UIViewController {

    @IBOutlet weak var temperatureScaleButton: UIButton!
    var currentTemperatureScale: Temperature.Scale = .celsius
    
    @IBOutlet weak var weatherBackground: UIImageView!
    
    @IBOutlet weak var formattedDateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherDayCollectionView: UICollectionView!
    @IBOutlet weak var hourlyWeatherStackView: UIStackView!
    
    var forecast: WeatherForecast?
    var selectedDayIndex: Int = 0
    var selectedHourIndex: Int = 0
    
    /// Returns the selectedDay object
    var selectedDay: WeatherDay? {
        return forecast?.weatherDays?[self.selectedDayIndex]
    }
    
    /// Returns the selectedHour object
    var selectedHour: HourlyWeather? {
        return selectedDay?.hourlyWeather[self.selectedHourIndex]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the hourlyViews
        setupHourlyViews()
        
        // Setup the views for the data we have
        setupViews()
    }
    
    /// Populates all the views with their correct data
    func setupViews() {
        // Set the date
        setDate()
        
        // Set all the temperatures on the views
        setTemperatures()
        
        // Set the weather icon and background
        weatherIcon.image = selectedHour?.weatherCode?.icon
        weatherBackground.image = selectedHour?.weatherCode?.background
        
        // Set the city label
        cityLabel.text = forecast?.city
        
        // Set the weatherDescriptionLabel
        weatherDescriptionLabel.text = selectedHour?.description
        
        // Animate the changes
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// Sets the date in the weather overview
    func setDate() {
        // Create the date
        let date = Date().addingTimeInterval(TimeInterval(86400 * selectedDayIndex))
        
        // Set the format on the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM, yyyy"
        dateFormatter.locale = Locale.current
        
        // Set the date
        formattedDateLabel.text = dateFormatter.string(from: date)
    }
    
    /// Sets the temperatures on the views
    func setTemperatures() {
        
        // Set the temperature scale button text
        temperatureScaleButton.setTitle("°\(currentTemperatureScale.otherScale.abbreviation)", for: .normal)
        
        // Set the real temperature
        if let temperature = selectedHour?.temperature.normal[currentTemperatureScale] {
            temperatureLabel.text = (temperature ?? "") + "°\(currentTemperatureScale.abbreviation)"
        }
        
        // Set the feels like temperature
        if let feelTemperature = selectedHour?.temperature.feel[currentTemperatureScale] {
            feelsLikeLabel.text = "Feels like \(feelTemperature ?? "")°\(currentTemperatureScale.abbreviation)"
        }
    }
    
    @IBAction func onTemperatureScaleChanged(_ sender: Any) {
        // Change the temperature scale
        currentTemperatureScale = currentTemperatureScale == .celsius ? .farenheit : .celsius
        
        // Update the temperatures
        setTemperatures()
        
        // Update the hourlyViews
        setupHourlyViews()
    }
    
    /// Handles the taps on the hourlyViews
    @objc func onHourlyViewTap(_ sender: UITapGestureRecognizer) {
        guard let hourlyView = sender.view,
            let index = hourlyWeatherStackView.arrangedSubviews.firstIndex(of: hourlyView) else { return }
        
        selectedHourIndex = index
        
        // Update the views
        setupViews()
        
        // Update the hourlyViews
        setupHourlyViews()
    }
}

// MARK: - HourlyWeatherView Customization
extension ForecastVC {
    /// Passes the hourlyWeather to each hourlyView
    func setupHourlyViews() {
        for case
            (let index, let hourlyView as HourlyWeatherView) in hourlyWeatherStackView.arrangedSubviews.enumerated() {
            
            if let hourlyWeather = self.selectedDay?.hourlyWeather[index] {
                // Pass the hourlyWeather to each hourlyView
                hourlyView.hourlyWeather = hourlyWeather
                
                // Add the tap gesture on the hourlyView
                let tap = UITapGestureRecognizer(target: self, action: #selector(onHourlyViewTap(_:)))
                hourlyView.addGestureRecognizer(tap)
                
                // Set up the hourWeatherView's subviews
                hourlyView.setupViews(forTempScale: currentTemperatureScale, isSelected: index == selectedHourIndex)
            }
        }
    }
}
