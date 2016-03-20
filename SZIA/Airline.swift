//
//  Airline.swift
//  SZIA
//
//  Created by Ádibádi on 27/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class Airline: NSObject {
    var id: Int32
    var name: String
    var imageURL: String
    var image: UIImage?
    var airlineCode: String
    
    init(id: Int32, name: String, imageURL: String, airlineCode: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        self.airlineCode = airlineCode
    }
}
