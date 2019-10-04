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
    @IBOutlet weak var savedCitiesDescription: UILabel!
    @IBOutlet weak var savedCitiesTableView: UITableView!
    
    var citiesWrapper = CitiesWrapper(withKey: "savedCities")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the tableview's footer
        savedCitiesTableView.tableFooterView = UIView()
        
        // Load the CityCell XIB
        savedCitiesTableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Toggle the saved cities texts
        toggleSavedCitiesTexts()
    }
    
    /// Shows or hides the saved cities title and description
    func toggleSavedCitiesTexts() {
        savedCitiesTitle.isHidden = citiesWrapper.cities.isEmpty
        savedCitiesDescription.isHidden = citiesWrapper.cities.isEmpty
        
        // Animate the changes
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    /// Requests the weather forecast from the API
    func requestWeatherForecast() {
        // Make sure there's an input and format it correctly
        if let city = citySearchField.text?.replacingOccurrences(of: " ", with: "+"), !city.isEmpty {
            // Start a new weather forecast request
            Networking.shared.getWeatherForecast(forCity: city)
            
            // Reset the citySearchField
            citySearchField.text = ""
        }
        
        // Dismiss the keyboard
        citySearchField.resignFirstResponder()
    }
    
    /// Saves the textField's input to the cities array, updates the tableView and clears the textField
    @IBAction func onSaveButtonTap(_ sender: Any) {
        guard let city = citySearchField.text, !city.isEmpty else { return }
        
        // Make sure the inserted city is not in the array
        if !citiesWrapper.cities.contains(city) {
            
            // Add the new element to the cities
            citiesWrapper.cities.insert(city, at: 0)
            
            // Save the new array to the UserDefaults
            citiesWrapper.save()
            
            // Update the saved cities texts
            toggleSavedCitiesTexts()
            
            // Update the savedCitiesTableView
            savedCitiesTableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
        }
        
        // Clear the textField and hide the keyboard
        citySearchField.text = ""
        citySearchField.resignFirstResponder()
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
        // Request the weather forecast
        requestWeatherForecast()
    }
    
    /// Adds the Swipe to Delete functionality to the tableView
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove the city from the cities
            citiesWrapper.cities.remove(at: indexPath.item)
            
            // Update the UserDefaults
            citiesWrapper.save()
            
            // Update the tableView
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            // Update the saved cities texts
            toggleSavedCitiesTexts()
        }
    }
}

// MARK: - TextField Delegate implementation
extension CityManagementVC: UITextFieldDelegate {
    
    /// Starts a request depending on the content of the textField & dismisses the keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Request the weather forecast
        requestWeatherForecast()
        
        return true
    }
}
