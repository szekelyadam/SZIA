//
//  DataManager.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class DataManager: NSObject {
    
    var airlines: [Airline]
    var departures: [Flight]
    
    override init() {
        // Init mock data
        let d1 = Flight(flightNumber: "LY 8046", departure: "South Zubogy International Airport", arrival: "Heatrow Airport", departureCity: "South Zubogy", departureCode: "SZU", arrivalCity: "London", arrivalCode: "LHR", departureTime: "2016-02-27T22:42:00.000Z", arrivalTime: "2016-02-28T01:02:00.000Z", status: "Boarding", checkinDeskNumber: 17, gateNumber: 22, delay: 0, comment: "WizzAir", id: 1, airlineId: 1)
        let d2 = Flight(flightNumber: "LY 8045", departure: "South Zubogy International Airport", arrival: "Heatrow Airport", departureCity: "South Zubogy", departureCode: "SZU", arrivalCity: "London", arrivalCode: "LHR", departureTime: "2016-02-27T22:42:00.000Z", arrivalTime: "2016-02-28T01:02:00.000Z", status: "Boarding", checkinDeskNumber: 17, gateNumber: 22, delay: 0, comment: "British Airways", id: 1, airlineId: 2)
        
        departures = [Flight]()
        departures.append(d1)
        departures.append(d2)
        
        let a1 = Airline(name: "WizzAir", logo: UIImage(named: "wizzair.png"), id: 1)
        let a2 = Airline(name: "British Airways", logo: UIImage(named: "british_airways.jpg"), id: 2)
        
        airlines = [Airline]()
        airlines.append(a1)
        airlines.append(a2)
        
        super.init()
    }
}
