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
    var selectedDay: Int = 0
    var selectedHour: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the views for the data we have
        setupViews()
    }
    
    /// Populates all the views with their correct data
    func setupViews() {
        // Get the selectedHour
        let selectedHour = forecast?.weatherDays?[self.selectedDay].hourlyWeather[self.selectedHour]
        
        // Set the temperature scale button text
        temperatureScaleButton.setTitle("°\(currentTemperatureScale.otherScale.abbreviation)", for: .normal)
        
        // Set the weather overview texts
        
        // Set the date
        setDate()
        
        // Set the temperature
        if let temperature = selectedHour?.temperature.normal[currentTemperatureScale] {
            temperatureLabel.text = (temperature ?? "") + "°\(currentTemperatureScale.abbreviation)"
        }
        
        // Set the weather icon and background
        weatherIcon.image = selectedHour?.weatherCode?.icon
        weatherBackground.image = selectedHour?.weatherCode?.background
        
        // Set the city label
        cityLabel.text = forecast?.city
        
        // Set the weather details texts
        if let feelTemperature = selectedHour?.temperature.feel[currentTemperatureScale] {
            feelsLikeLabel.text = "Feels like \(feelTemperature ?? "")°\(currentTemperatureScale.abbreviation)"
        }
        
        weatherDescriptionLabel.text = selectedHour?.description
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
    
    /// Sets the date in the weather overview
    func setDate() {
        // Create the date
        let date = Date().addingTimeInterval(TimeInterval(86400 * selectedDay))
        
        // Set the format on the date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM, yyyy"
        dateFormatter.locale = Locale.current
        
        // Set the date
        formattedDateLabel.text = dateFormatter.string(from: date)
    }
    
    @IBAction func onTemperatureScaleChanged(_ sender: Any) {
        // Change the temperature scale
        currentTemperatureScale = currentTemperatureScale == .celsius ? .farenheit : .celsius
        
        // Update the views
        setupViews()
    }
}
