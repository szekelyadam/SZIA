//
//  ArrivalsViewController.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit
import CoreData

class ArrivalsViewController: UITableViewController {
    
    var arrivals = [Flight]()
    var urlSession : NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        self.loadArrivals()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.loadArrivals()
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrivals.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FlightCell = tableView.dequeueReusableCellWithIdentifier("ArrivalsTableViewCell", forIndexPath: indexPath) as! FlightCell
        
        let arrivalData = arrivals[indexPath.row] as Flight
        
        cell.flightNumberLabel.text = "\(arrivalData.departureCode!) -> \(arrivalData.arrivalCode!) - \(arrivalData.flightNumber!)"
        cell.timeLabel.text = arrivalData.arrivalTime
        cell.infosLabel.text = arrivalData.comment
        if arrivalData.getAirline() != nil && arrivalData.getAirline()!.image != nil {
            cell.airlineImageView.image = arrivalData.getAirline()!.image!
        }
        cell.favouriteButton.tag = Int(arrivalData.id)
        
        if arrivalData.managedObjectContext != nil {
            cell.favouriteButton.setTitle("★", forState: .Normal)
        } else {
            cell.favouriteButton.setTitle("☆", forState: .Normal)
        }
        
        return cell
    }
    
    @IBAction func favouriteButtonTapped(sender: UIButton) {
        for arrival in self.arrivals {
            if arrival.id == Int32(sender.tag) {
                do {
                    let context = AppDelegate.sharedAppDelegate().managedObjectContext
                    if arrival.managedObjectContext != nil {
                        context.deleteObject(arrival)
                        try context.save()
                        sender.setTitle("☆", forState: .Normal)
                    } else {
                        let tmpFlight = Flight(
                            flightNumber: arrival.flightNumber!,
                            departure: arrival.departure!,
                            arrival: arrival.arrival!,
                            departureCity: arrival.departureCity!,
                            departureCode: arrival.departureCode!,
                            arrivalCity: arrival.arrivalCity!,
                            arrivalCode: arrival.arrivalCode!,
                            departureTime: arrival.departureTime!,
                            arrivalTime: arrival.arrivalTime!,
                            status: arrival.status!,
                            checkinDeskNumber: arrival.checkinDeskNumber,
                            gateNumber: arrival.gateNumber,
                            delay: arrival.delay,
                            comment: arrival.comment!,
                            id: arrival.id,
                            airlineId: 1,
                            needSave: true,
                            context: context
                        )
                        context.deleteObject(arrival)
                        try tmpFlight.managedObjectContext?.save()
                        sender.setTitle("★", forState: .Normal)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }

    
    func loadArrivals() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.arrivals.removeAll()
        var storedArrivalsIds = [Int32]()
        var storedArrivals = [Flight]()
        
        let context = AppDelegate.sharedAppDelegate().managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Flight", inManagedObjectContext: context)
        fetchRequest.entity = entityDescription
        
        do {
            let savedArrivals = try context.executeFetchRequest(fetchRequest)
            for a in savedArrivals {
                if a.arrivalCode! == "SZU" {
                    arrivals.append(a as! Flight)
                    storedArrivals.append(a as! Flight)
                    storedArrivalsIds.append(a.id)
                }
            }
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        let url = NSURL(string: "http://szia-backend.herokuapp.com/api/flights")
        let dataTask = urlSession.dataTaskWithURL(url!, completionHandler: { data, response, error in
            
            do {
                if data != nil {
                    self.arrivals.removeAll()
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? [AnyObject] else {
                        return
                    }
                    self.arrivals.appendContentsOf(storedArrivals)
                    for object in jsonArray {
                        let a = object as! [NSObject: AnyObject]
                        if a["arrivalCode"] as! String == "SZU" && !storedArrivalsIds.contains(Int32(a["id"] as! Int)) {
                            let newFlight = Flight(
                                flightNumber: a["flightNumber"] as! String,
                                departure: a["departure"] as! String,
                                arrival: a["arrival"] as! String,
                                departureCity: a["departureCity"] as! String,
                                departureCode: a["departureCode"] as! String,
                                arrivalCity: a["arrivalCity"] as! String,
                                arrivalCode: a["arrivalCode"] as! String,
                                departureTime: a["departureTime"] as! String,
                                arrivalTime: a["arrivalTime"] as! String,
                                status: a["status"] as! String,
                                checkinDeskNumber: Int32(a["checkinDeskNumber"] as! Int),
                                gateNumber: Int32(a["gateNumber"] as! Int),
                                delay: Int32(a["delay"] as! Int),
                                comment: a["comment"] as! String,
                                id: Int32(a["id"] as! Int) ,
                                airlineId: 1,
                                needSave: false,
                                context: context
                            )
                            self.arrivals.append(newFlight)
                        }
                    }
                }
                self.tableView.reloadData()
                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            } catch {
                print("Error \(error)")
            }
        })
        self.tableView.reloadData()
        dataTask.resume()
    }

    @IBAction func refreshButtonTapped(sender: UIButton) {
        loadArrivals()
    }
    
}
