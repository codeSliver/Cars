//
//  CarListService.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation

typealias CarsCompletionBlock = (_ cars: [Car]?,_ error: String?)-> ()

/// Service for fetching car list from the network
struct CarsService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}

extension CarsService {
    
    /// Fetches the list of cras using the *CarAPI * *carList* end point
    /// - Parameter completion: completion closure with array of *Car*  objects or error string
    func fetchCars(_ completion: @escaping CarsCompletionBlock) {
        networkHandler.fetchData(CarAPI.carList, completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            do {
                let jsonDecoder = JSONDecoder()
                let cars = try jsonDecoder.decode([Car].self, from: data)
                completion(cars, nil)
            } catch {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
