//
//  carCellViewModel.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import UIKit

typealias ImageFetched = ((_ image: UIImage)->())

/// viewModel to serve the *CarView*
class CarViewModel {
    private var car: Car!
    var imageFetched: ImageFetched?
    var imageService = ImageService(NetworkHandler())
    
    private init(){}

    /// convenience initialiser to initialise view model with a *Car* model
    /// - Parameter carModel: *Car* model
    convenience init(_ carModel:Car) {
        self.init()
        car = carModel
    }
    
}
//MARK:- View Service Methods
extension CarViewModel {
    
    /// fetches car image
    func fetchCarImage() {
        fetchImageForCar(car)
    }
    
    /// fetches car image for the passed car and calls *imageFetched* closure if a valid image is recieved that belongs to the current *Car*  model in the view model
    /// - Parameter carToFetch: *Car* model
    private func fetchImageForCar(_ carToFetch: Car) {
        guard let path = imagePath(carToFetch) else { return }
        imageService.fetchImage(path) { [weak self] (image, error) in
            if let _ = error { return }
            guard let image = image else { return }
            
            if let carModel = self?.car, carModel.carImageUrl == carToFetch.carImageUrl {
                self?.imageFetched?(image)
            }
        }
    }
    
    /// Returns last path component for the car image url so that it could be sent over the network by merging it with base network url, returns nil if url is not correct
    /// - Parameter carToFetch: *Car* model
    private func imagePath(_ carToFetch: Car) -> String? {
        guard let urlString = car.carImageUrl else { return nil }
        guard let url = URL(string: urlString) else { return nil }
        return url.lastPathComponent
    }
    
    /// Returns car license plate or an empty string if *licensePlate* is nil
    func carlicensePlate() -> String {
        return car.licensePlate ?? ""
    }
    
    /// Returns car driver name or an empty string if *name* is nil
    func carDriver() -> String {
        return car.name ?? ""
    }
    
    /// Returns car model name or an empty string if *modelName* is nil
    func carModel() -> String {
        return car.modelName ?? ""
    }
}
