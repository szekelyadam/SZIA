//
//  Airline.swift
//  SZIA
//
//  Created by Ádibádi on 27/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class Airline: NSObject {
    var name: String
    var logo: UIImage?
    var id: Int
    
    init(name: String, logo: UIImage?, id: Int) {
        self.name = name
        self.logo = logo!
        self.id = id
    }
}
