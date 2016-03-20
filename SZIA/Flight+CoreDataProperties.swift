//
//  Flight+CoreDataProperties.swift
//  SZIA
//
//  Created by Ádibádi on 19/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Flight {

    @NSManaged var flightNumber: String?
    @NSManaged var departure: String?
    @NSManaged var arrival: String?
    @NSManaged var departureCity: String?
    @NSManaged var departureCode: String?
    @NSManaged var arrivalCity: String?
    @NSManaged var arrivalCode: String?
    @NSManaged var departureTime: String?
    @NSManaged var arrivalTime: String?
    @NSManaged var status: String?
    @NSManaged var checkinDeskNumber: Int32
    @NSManaged var gateNumber: Int32
    @NSManaged var delay: Int32
    @NSManaged var comment: String?
    @NSManaged var id: Int32
    @NSManaged var airlineId: Int32

}
