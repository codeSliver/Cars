//
//  carAnnotation.swift
//  Cars
//
//  Created by Arslan Faisal on 29/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import MapKit

/// Provides car annotation to be created on the  map at specific location
class CarAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var car: Car
    
    /// Initialises the CarAnnotation with a specific car
    /// - Parameter carOnMap: *Car* object to be shown on map
    init(_ carOnMap: Car) {
        car = carOnMap
        if let lat = car.latitude, let long = car.longitude {
            coordinate = CLLocationCoordinate2DMake(lat, long)
        }else {
            coordinate = Location.defaultLocation
        }
        super.init()
    }
    
}
