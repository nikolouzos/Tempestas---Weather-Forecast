//
//  Networking.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

// MARK: - Networking Delegate
protocol NetworkingDelegate: class {
    func gotWeatherForecast(_ forecast: WeatherForecast?)
}

/// The class that handles the Networking for the application.
/// You can find the API documentation at: https://www.worldweatheronline.com/developer/api/docs/local-city-town-weather-api.aspx
class Networking {
    
    // Networking Singleton
    static let shared = Networking()
    
    // Delegate
    weak var delegate: NetworkingDelegate?
    
    // MARK: - Constants
    private struct Constants {
        static let baseUrl = URL(string: "https://api.worldweatheronline.com/premium/v1/weather.ashx")
        static let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        
        // MARK: - Parameters
        static let format = "json"
        
        // The weather forecast time interval in hours
        static let forecastTimeInterval = "6"
        
        static let numOfDays = "5"
        
        // Whether to return monthly climate average data?
        static let climateAvgData = "no"
        
        // Whether to return current weather conditions
        static let weatherConditions = "no"
        
        /// Returns the parameters in Dictionary format
        static func toDict() -> [String: String] {
            return [
                "format": format,
                "tp": forecastTimeInterval,
                "num_of_days": numOfDays,
                "mca": climateAvgData,
                "cc": weatherConditions
            ]
        }
    }
    
    // MARK: - Methods
    
    /// Starts a weather forecast request for the next 5 days
    func getWeatherForecast(forCity city: City) {
        // Get the baseUrl and make sure we have the API key
        guard let baseUrl = Constants.baseUrl,
            let apiKey = Constants.apiKey, !apiKey.isEmpty else { return }
        
        // Add the city to the parameters
        var params = Constants.toDict()
        params["key"] = apiKey
        params["q"] = city
        
        // Make the request
        AF.request(baseUrl, method: .get, parameters: params).response { response in
            debugPrint(response)
            
            if let data = response.data, let json = try? JSON(data: data) {
                
               // Parse the JSON
                let forecast = WeatherForecast(fromJSON: json["data"])
                
                // Call the delegate
                self.delegate?.gotWeatherForecast(forecast)
            }
        }
    }
}
