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
    
    @IBOutlet weak var savedCitiesTableView: UITableView!
    var cities: Cities = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove the tableview's footer
        savedCitiesTableView.tableFooterView = UIView()
    }
}

// MARK: - TableView Delegate & Data Source implementation
extension CityManagementVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Create the CityCell
        guard let cityCell = tableView.dequeueReusableCell(
            withIdentifier: "cityCell") as? CityCell else { return UITableViewCell() }
        
        // Customize the city cell
        let currentCity = cities[indexPath.item]
        cityCell.setupCell(forCity: currentCity)
        
        return cityCell
    }
}
