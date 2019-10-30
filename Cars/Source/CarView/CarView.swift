//
//  CarView.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import UIKit

@IBDesignable
/// Custom view class to be used for displaying car info on the map and on table view cell
class CarView: UIView {
    
    var viewModel: CarViewModel?

    @IBOutlet weak var carColorLbl: UILabel!
    @IBOutlet weak var carModelLbl: UILabel!
    @IBOutlet weak var driverNameLbl: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    /// Intialises view from the nib file
    private func commonInit() {
        let bundle = Bundle.init(for: CarView.self)
        if let viewsToAdd = bundle.loadNibNamed("CarView", owner: self, options: nil), let contentView = viewsToAdd.first as? UIView {
            addSubview(contentView)
            contentView.frame = self.bounds
            contentView.autoresizingMask = [.flexibleHeight,
                                            .flexibleWidth]
        }
    }
}
extension CarView {
    
    /// Setup view with passed  *Car* model and binds view model
    /// - Parameter car: *Car* model
    func setUpView(_ car:Car) {
        viewModel = CarViewModel(car)
        
        carColorLbl.text = "Plate: " + viewModel!.carlicensePlate()
        driverNameLbl.text = "Driver: " + viewModel!.carDriver()
        carModelLbl.text = "Model: " + viewModel!.carModel()
        carImageView.image = #imageLiteral(resourceName: "defaultCarIcon")
        
        viewModel?.imageFetched = { [weak self] (image) in
            DispatchQueue.main.async { [weak self] in
                self?.carImageView.image = image
            }
        }
        
        viewModel?.fetchCarImage()
    }
}
