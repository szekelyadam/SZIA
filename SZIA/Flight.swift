//
//  Flight.swift
//  SZIA
//
//  Created by Ádibádi on 19/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import Foundation
import CoreData

@objc(Flight)
class Flight: NSManagedObject {
    
    convenience init(flightNumber: String, departure: String, arrival: String, departureCity: String, departureCode: String, arrivalCity: String, arrivalCode: String, departureTime: String, arrivalTime: String, status: String, checkinDeskNumber: Int32, gateNumber: Int32, delay: Int32, comment: String, id: Int32, airlineId: Int32, needSave: Bool,  context: NSManagedObjectContext?) {
        
        // Create the NSEntityDescription
        let entity = NSEntityDescription.entityForName("Flight", inManagedObjectContext: context!)
        
        
        if(!needSave) {
            self.init(entity: entity!, insertIntoManagedObjectContext: nil)
        } else {
            self.init(entity: entity!, insertIntoManagedObjectContext: context)
        }
        
        // Init class variables
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
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
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
