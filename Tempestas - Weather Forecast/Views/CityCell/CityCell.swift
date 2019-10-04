//
//  CityCell.swift
//  Tempestas - Weather Forecast
//
//  Created by Nikolaos Rafail Nikolouzos on 4/10/19.
//  Copyright © 2019 Nikolaos Rafail Nikolouzos. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    @IBOutlet weak var city: UILabel!
    
    /// Sets up the cell for the City provided
    func setupCell(forCity city: City) {
        // Set the cell's title
        self.city.text = city
    }
}
