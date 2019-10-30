//
//  Car.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation


/// holds all the properties of a *Car* object and confirms to *Decodable* protocol
struct Car: Decodable {
    var id:                 String?
    var modelIdentifier:    String?
    var modelName:          String?
    var name:               String?
    var make:               String?
    var group:              String?
    var color:              String?
    var series:             String?
    var fuelType:           String?
    var fuelLevel:          Float?
    var transmission:       String?
    var licensePlate:       String?
    var latitude:           Double?
    var longitude:          Double?
    var innerCleanliness:   String?
    var carImageUrl:        String?
}
