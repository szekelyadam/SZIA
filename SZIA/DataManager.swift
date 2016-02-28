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
    var arrivals: [Flight]
    var news: [News]
    
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
        
        let ar1 = Flight(flightNumber: "LY 8046", departure: "Heatrow Airport", arrival: "South Zubogy International Airport", departureCity: "London", departureCode: "LHR", arrivalCity: "South Zubogy", arrivalCode: "SZU", departureTime: "2016-02-27T22:42:00.000Z", arrivalTime: "2016-02-28T01:02:00.000Z", status: "Boarding", checkinDeskNumber: 17, gateNumber: 22, delay: 0, comment: "WizzAir", id: 1, airlineId: 1)
        let ar2 = Flight(flightNumber: "LY 8045", departure: "Heatrow Airport", arrival: "South Zubogy International Airport", departureCity: "London", departureCode: "LHR", arrivalCity: "South Zubogy", arrivalCode: "SZU", departureTime: "2016-02-27T22:42:00.000Z", arrivalTime: "2016-02-28T01:02:00.000Z", status: "Boarding", checkinDeskNumber: 17, gateNumber: 22, delay: 0, comment: "British Airways", id: 1, airlineId: 2)
        
        arrivals = [Flight]()
        arrivals.append(ar1)
        arrivals.append(ar2)
        
        let n1 = News(date: "2016-02-10T10:01:12.000Z", title: "Nagyon menő a repülőtér", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        let n2 = News(date: "2016-02-11T13:01:12.000Z", title: "Rendkívül király a repülőtér", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
        
        news = [News]()
        news.append(n1)
        news.append(n2)
        
        super.init()
    }
}
