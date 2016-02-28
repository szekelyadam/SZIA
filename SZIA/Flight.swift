//
//  Flight.swift
//  SZIA
//
//  Created by Ádibádi on 27/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class Flight: NSObject {
    var flightNumber: String
    var departure: String
    var arrival: String
    var departureCity: String
    var departureCode: String
    var arrivalCity: String
    var arrivalCode: String
    var departureTime: NSDate?
    var arrivalTime: NSDate?
    var status: String
    var checkinDeskNumber: Int
    var gateNumber: Int
    var delay: Int
    var comment: String
    var id: Int
    var airlineId: Int
    
    init(flightNumber: String, departure: String, arrival: String, departureCity: String, departureCode: String, arrivalCity: String, arrivalCode: String, departureTime: String, arrivalTime: String, status: String, checkinDeskNumber: Int, gateNumber: Int, delay: Int, comment: String, id: Int, airlineId: Int) {
        self.flightNumber = flightNumber
        self.departure = departure
        self.arrival = arrival
        self.departureCity = departureCity
        self.departureCode = departureCode
        self.arrivalCity = arrivalCity
        self.arrivalCode = arrivalCode
        self.status = status
        self.checkinDeskNumber = checkinDeskNumber
        self.gateNumber = gateNumber
        self.delay = delay
        self.comment = comment
        self.id = id
        self.airlineId = airlineId
        
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self.departureTime = dateFormatter.dateFromString(departureTime)
        self.arrivalTime = dateFormatter.dateFromString(arrivalTime)
    }
    
    func getAirline() -> Airline? {
        let dataManager = AppDelegate.sharedAppDelegate().dataManager
        
        for airline in dataManager.airlines {
            if airline.id == self.airlineId {
                return airline
            }
        }
        
        return nil
    }
}
