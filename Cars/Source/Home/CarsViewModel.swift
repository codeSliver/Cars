//
//  CarsViewModel.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias CarsFetchedCallBack = ((_ cars:[Car])->())

/// type of view being displayed list or map
enum ViewType {
    case list
    case map
}

/// ViewModel to serve the *CarsViewController*
class CarsViewModel {
    private var carsService = CarsService(NetworkHandler())
    private(set) var cars   = [Car]()
    var viewType: Bindable<ViewType> = Bindable(ViewType.list)
    
    var carsFetched    = [CarsFetchedCallBack?]()
    var carsFetchFailed: ((_ error: String)->())?

    init() {
        let _ = NetworkReachability.shared
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
//MARK:- Network Fetch
extension CarsViewModel {
    
    /// Fetch a list of cars from network and calls either the *carsFetchFailed* closure on error or the *carsFetched* on successfully getting the cars data
    func fetchCars() {
        carsService.fetchCars { [weak self] (cars, error) in
            if let error = error {
                self?.addConnectivityObserver()
                self?.carsFetchFailed?(error)
            } else if let cars = cars {
                self?.cars.removeAll()
                self?.cars = cars
                self?.carsFetched.forEach { carsFetched in
                    carsFetched?(cars)
                }
            }
        }
    }
    func addConnectivityObserver() {
        NotificationCenter.default.removeObserver(self)
        NotificationCenter.default.addObserver(self, selector: #selector(self.connectivityChanged(notification:)), name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: nil)
    }
    @objc func connectivityChanged(notification: Notification) {
        guard let connectivity = notification.object as? Bool else { return }
        if connectivity && cars.isEmpty {
            fetchCars()
        }
    }
}
