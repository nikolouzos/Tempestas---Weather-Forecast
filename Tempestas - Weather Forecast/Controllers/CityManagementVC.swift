//
//  CityManagementVC.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 3/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit
import IBAnimatable

/// This ViewController manages the user's saved cities and performs weather forecast searches
class CityManagementVC: UIViewController {
    
    @IBOutlet weak var citySearchField: CustomAnimatableTextField!
    
    @IBOutlet weak var savedCitiesTitle: UILabel!
    @IBOutlet weak var savedCitiesDescription: UILabel!
    @IBOutlet weak var savedCitiesTableView: UITableView!
    
    // The button is out by default
    var buttonState: AnimationType.Way = .in
    @IBOutlet weak var saveCityButton: AnimatableButton!
    
    @IBOutlet weak var loader: AnimatableActivityIndicatorView!
    
    var citiesWrapper = CitiesWrapper(withKey: "savedCities")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the tableview's footer
        savedCitiesTableView.tableFooterView = UIView()
        
        // Load the CityCell XIB
        savedCitiesTableView.register(UINib(nibName: "CityCell", bundle: nil), forCellReuseIdentifier: "cityCell")
        
        // Make sure the saveCityButton is hidden
        animateSaveCityButton(.out)
        
        // Detect the text changes on the citySearchField
        citySearchField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Toggle the saved cities texts
        toggleSavedCitiesTexts()
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
        
        // Animate the saveCityButton out
        animateSaveCityButton(.out)
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
            
            // Show the loader
            loader.startAnimating()
            
            // Add the Networking delegate
            Networking.shared.delegate = self
            
            // Start a new weather forecast request
            Networking.shared.getWeatherForecast(forCity: city)
            
            // Reset the citySearchField
            citySearchField.text = ""
            
            // Animate the saveCityButton out
            animateSaveCityButton(.out)
        }
        
        // Dismiss the keyboard
        citySearchField.resignFirstResponder()
    }
    
    /// Animates the saveCityButton to slide in or out
    func animateSaveCityButton(_ way: AnimationType.Way) {
        // Make sure we are not repeating the animation
        guard way != buttonState else { return }
        
        // Do the animation
        saveCityButton.animate(.slideFade(way: way, direction: way == .in ? .left : .right), duration: 0.3)
        
        // Update the buttonState
        buttonState = way
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
    
    /// Animates the saveCityButton in or out depending on the content of the citySearchField
    @objc func textFieldDidChange(_ sender: UITextField) {
        let way: AnimationType.Way = citySearchField.text != "" ? .in : .out
        
        animateSaveCityButton(way)
    }
}

// MARK: - Networking Delegate implementation
extension CityManagementVC: NetworkingDelegate {
    func gotWeatherData() {
        // Stop the loader
        loader.stopAnimating()
    }
}
