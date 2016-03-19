//
//  Airline.swift
//  SZIA
//
//  Created by Ádibádi on 27/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class Airline: NSObject {
    var id: Int
    var name: String
    var imageURL: String
    var image: UIImage?
    var airlineCode: String
    
    init(id: Int, name: String, imageURL: String, airlineCode: String) {
        self.id = id
        self.name = name
        self.imageURL = imageURL
        let url = NSURL(string: imageURL)
        let data = NSData(contentsOfURL: url!)
        self.image = UIImage(data: data!)
        self.airlineCode = airlineCode
    }
}
