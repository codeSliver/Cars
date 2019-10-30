//
//  NetworkReachability.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import Network

struct NetworkReachability {
    
    static var shared = NetworkReachability()
    
    /// To check if the  phone is connected to internet and notification "networkReachability" is fired on connectivity status changed
    var isConnected = true {
        didSet {
            let connectionStatus = isConnected
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotificationNames.networkReachability), object: connectionStatus)
        }
    }
    
    private init(){
        startCheckingForConnectivity()
    }
    
    /// continuously checks internet connectivity status and
    private func startCheckingForConnectivity() {
        let networkMoniter = NWPathMonitor()
        let queue = DispatchQueue.global(qos: .background)
        networkMoniter.start(queue: queue)
        networkMoniter.pathUpdateHandler = { path in
            NetworkReachability.shared.isConnected = path.status == .satisfied
        }
    }
}
