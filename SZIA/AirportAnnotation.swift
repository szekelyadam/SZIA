//
//  AirportAnnotation.swift
//  SZIA
//
//  Created by Ádibádi on 06/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit
import MapKit

class AirportAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
