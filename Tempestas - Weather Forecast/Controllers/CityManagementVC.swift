//
//  CityManagementVC.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 3/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

/// This ViewController manages the user's saved cities and performs weather forecast searches
class CityManagementVC: UIViewController {
    
    @IBOutlet weak var citySearchField: CustomAnimatableTextField!
    
    @IBOutlet weak var savedCitiesTitle: UILabel!
    @IBOutlet weak var savedCitiesTableView: UITableView!
    
    var citiesWrapper = CitiesWrapper(withKey: "savedCities")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the tableview's footer
        savedCitiesTableView.tableFooterView = UIView()
        
        // Load the CityCell XIB
        savedCitiesTableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
}

// MARK: - TableView Delegate & Data Source implementation
extension CityManagementVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesWrapper.cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create the CityCell
        guard let cityCell = tableView.dequeueReusableCell(
            withIdentifier: "cityCell", for: indexPath) as? CityCell else { return UITableViewCell() }
        
        // Customize the city cell
        let currentCity = citiesWrapper.cities[indexPath.item]
        cityCell.setupCell(forCity: currentCity)
        
        return cityCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
}

// MARK: - TextField Delegate implementation
extension CityManagementVC: UITextFieldDelegate {
    
    /// Starts a request depending on the content of the textField & dismisses the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Make sure there's an input and format it correctly
        if let city = textField.text?.replacingOccurrences(of: " ", with: "+"), !city.isEmpty {
            // Start a new weather forecast request
            Networking.shared.getWeatherForecast(forCity: city)
            
            // Reset the textField
            textField.text = ""
        }
        
        // Dismiss the keyboard
        textField.resignFirstResponder()
        
        return true
    }
}
