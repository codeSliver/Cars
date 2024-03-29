//
//  ImageService.swift
//  Cars
//
//  Created by Arslan Faisal on 28/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletionBlock = (_ image: UIImage?,_ error: String?)-> ()

/// Service for fetching car image from the network
struct ImageService {
    var networkHandler: NetworkHandler
    init(_ networkHandle: NetworkHandler) {
        networkHandler = networkHandle
    }
}
extension ImageService {
    /// Fetches the car image  using the *CarAPI * *carImage* end point
    /// - Parameter completion: completion closure with *UIImage*  or error string
    func fetchImage(_ path: String, completion: @escaping ImageCompletionBlock) {
        networkHandler.fetchData(CarAPI.carImage(path: path), completion: {(data, error) in
            guard let data = data else {
                completion(nil,error)
                return
            }
            if let image = UIImage(data: data) {
                completion(image, nil)
            } else {
                completion(nil, NetworkResponse.unableToDecode.rawValue)
            }
        })
    }
}
