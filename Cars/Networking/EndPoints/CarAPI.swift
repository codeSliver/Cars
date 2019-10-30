//
//  CarAPI.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation


/// Define different endpoint cases for the sixt car API to be used for network request
enum CarAPI {
    case carList
    case carImage(path:String)
}

extension CarAPI: EndPointType {
    
    /// computed property for providing base url based on the network environment
    private var envBaseURL: String {
        switch NetworkHandler.environment {
        case .production:
            return "https://cdn.sixt.io/codingtask/"
        default:
            return "https://cdn.sixt.io/codingtask/"
        }
    }
    
    /// computed property for providing a *URL* with the base url string
    var baseURL: URL {
        guard let url = URL(string: envBaseURL) else {fatalError("Invalid Base URL.")}
        return url
    }
    
    /// computed property to provide specific path for each API end point
    var path: String {
        switch self {
        case .carList:
            return "cars"
        case .carImage(let path):
            return "images/" + path
        }
    }
    
    /// computed property to provide HTTP request method to be used in network request
    var httpMethod: HTTPMethod {
        return .get
    }
    
    /// computed property to provide request with specific query string parameters if required
    var task: HTTPTask {
       return .request(urlParams: nil)
    }
}
