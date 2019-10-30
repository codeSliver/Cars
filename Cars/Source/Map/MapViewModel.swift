//
//  MapViewModel.swift
//  Cars
//
//  Created by Arslan Faisal on 29/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

/// ViewModel to serve *MapViewController*
class MapViewModel {
    
    private(set) var cars: Bindable<[Car]>!
    private var annotations = [CarAnnotation]()

    var carsFetchedCallBack: CarsFetchedCallBack!
    
    private init() {}
    
    /// Convenience initialiser to initialise view model with an array  of cars
    /// - Parameter carsList: array of *Car*
    convenience init(_ carsList:[Car]) {
        self.init()
        cars = Bindable(carsList)
        carsFetchedCallBack = { [weak self] cars in
            guard let unwrappedSelf = self else { return }
            if let _ =  unwrappedSelf.cars, !unwrappedSelf.annotations.isEmpty {
                self?.cars.value.removeAll()
                self?.annotations.removeAll()
            }
            self?.cars.value = cars
        }
    }
}
extension MapViewModel {
    
    /// Returns an array of map annotations
    func mapAnnotations() -> [CarAnnotation] {
        createAnnotations()
        return annotations
    }
    
    /// Creates carAnnotations and add them to annotations array if its  empty otherwise returns the already created array
    private func createAnnotations() {
        guard annotations.isEmpty else { return }
        
        cars.value.forEach { car in
            let carAnnotation = CarAnnotation(car)
            annotations.append(carAnnotation)
        }
    }
}
