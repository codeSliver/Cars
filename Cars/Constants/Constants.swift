//
//  Constants.swift
//  Cars
//
//  Created by Arslan Faisal on 27/10/2019.
//  Copyright © 2019 Arslan Faisal. All rights reserved.
//

import Foundation
import CoreLocation

enum NotificationNames {
    static let networkReachability = "networkReachability"
}

enum Segues {
    static let listEmbeddedSegue = "listEmbeddedSegue"
    static let mapEmbeddedSegue  = "mapEmbeddedSegue"
}

enum CellIdentifiers {
    static let carCellIdentifier = "carCellIdentifier"
}
enum MapIdentifiers {
    static let carMapdentifier          = "carMapdentifier"
    static let carMapViewTag            = 1122
    static let mapAnnotationViewWidth   = 374
    static let mapAnnotationViewHeight  = 100
}
enum Location {
    static let defaultLocation = CLLocationCoordinate2DMake(21.282778, -157.829444)
}
