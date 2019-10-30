//
//  CarTableViewCell.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    @IBOutlet weak var carView: CarView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Setup cell for a specific car
    /// - Parameter car: *Car* model
    func setupCell(_ car: Car) {
        carView.setUpView(car)
    }
}
