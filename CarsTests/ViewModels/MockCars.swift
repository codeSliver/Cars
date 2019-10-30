//
//  MockCars.swift
//  CarsTests
//
//  Created by Arslan Faisal on 30/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
@testable import Cars

protocol MockCars {
    @discardableResult
    func carsFromJsonFile() -> [Car]?
}
extension MockCars {
    @discardableResult
    func carsFromJsonFile() -> [Car]? {
        guard let url = Bundle.main.url(forResource: "cars", withExtension: "json") else { return nil}
        guard let mockResponse: String = try? String(contentsOf: url) else { return nil }
        guard let data = mockResponse.data(using: .utf8, allowLossyConversion: false) else { return nil }
        let jsonDecoder = JSONDecoder()
        let cars = try? jsonDecoder.decode([Car].self, from: data)
        return cars
    }
}
