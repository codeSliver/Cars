//
//  ListViewModel.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation


/// ViewModel to serve the *ListViewController*
class ListViewModel {
    
    private(set) var cars: Bindable<[Car]>!
    var carsFetchedCallBack: CarsFetchedCallBack!
    
    private init() {}
    
    /// Convenience initialiser to initialise view model with an array  of cars
    /// - Parameter carsList: array of *Car*
    convenience init(_ carsList:[Car]) {
        self.init()
        cars = Bindable(carsList)
        carsFetchedCallBack = { [weak self] cars in
            self?.cars.value = cars
        }
    }
}
//MARK:- View Service Methods
extension ListViewModel {
    
    /// Returns total number of cars in cars array
    func numberOfCars() -> Int {
        return cars.value.count
    }
    
    /// Returns a *Car* at specific index
    /// - Parameter index: array index
    func carAtIndex(index: Int) -> Car? {
        guard index >= 0 && index < cars.value.count else { return nil }
        return cars.value[index]
    }
}
