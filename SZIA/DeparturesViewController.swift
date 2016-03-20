//
//  DeparturesViewController.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit
import CoreData
import FontAwesome_swift
import Kingfisher

class DeparturesViewController: UITableViewController {
    
    var departures = [Flight]()
    var urlSession : NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        self.loadDepartures()
        self.tabBarItem.image = UIImage.fontAwesomeIconWithName(.Github, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))

    }
    
    override func viewWillAppear(animated: Bool) {
        loadDepartures()
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

    @IBAction func refreshButtonTap(sender: AnyObject) {
        loadDepartures()
    }
    
    @IBAction func favouriteButtonTapped(sender: UIButton) {
        for departure in self.departures {
            if departure.id == Int32(sender.tag) {
                do {
                    let context = AppDelegate.sharedAppDelegate().managedObjectContext
                    if departure.managedObjectContext != nil {
                        context.deleteObject(departure)
                        try context.save()
                        sender.setTitle("☆", forState: .Normal)
                    } else {
                        let tmpFlight = Flight(
                            flightNumber: departure.flightNumber!,
                            departure: departure.departure!,
                            arrival: departure.arrival!,
                            departureCity: departure.departureCity!,
                            departureCode: departure.departureCode!,
                            arrivalCity: departure.arrivalCity!,
                            arrivalCode: departure.arrivalCode!,
                            departureTime: departure.departureTime!,
                            arrivalTime: departure.arrivalTime!,
                            status: departure.status!,
                            checkinDeskNumber: departure.checkinDeskNumber,
                            gateNumber: departure.gateNumber,
                            delay: departure.delay,
                            comment: departure.comment!,
                            id: departure.id,
                            airlineId: 1,
                            needSave: true,
                            context: context
                        )
                        context.deleteObject(departure)
                        try tmpFlight.managedObjectContext?.save()
                        sender.setTitle("★", forState: .Normal)
                    }
                } catch {
                    print(error)
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departures.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FlightCell = tableView.dequeueReusableCellWithIdentifier("DeparturesTableViewCell", forIndexPath: indexPath) as! FlightCell
    
        let departureData = departures[indexPath.row] as Flight
        
        cell.flightNumberLabel.text = "\(departureData.departureCode!) -> \(departureData.arrivalCode!) - \(departureData.flightNumber!)"
        cell.timeLabel.text = departureData.departureTime
        cell.infosLabel.text = departureData.comment
        if departureData.getAirline() != nil && departureData.getAirline()!.imageURL != "" {
            cell.airlineImageView.kf_setImageWithURL(NSURL(string: departureData.getAirline()!.imageURL)!)
        }
        cell.favouriteButton.tag = Int(departureData.id)
        
        if departureData.managedObjectContext != nil {
            cell.favouriteButton.setTitle("★", forState: .Normal)
        } else {
            cell.favouriteButton.setTitle("☆", forState: .Normal)
        }
        
        return cell
    }
    
    func loadDepartures() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.departures.removeAll()
        var storedDeparturesIds = [Int32]()
        var storedDepartures = [Flight]()
        
        let context = AppDelegate.sharedAppDelegate().managedObjectContext
        let fetchRequest = NSFetchRequest()
        let entityDescription = NSEntityDescription.entityForName("Flight", inManagedObjectContext: context)
        fetchRequest.entity = entityDescription
        
        do {
            let savedDepartures = try context.executeFetchRequest(fetchRequest)
            for d in savedDepartures {
                if d.departureCode! == "SZU" {
                    departures.append(d as! Flight)
                    storedDepartures.append(d as! Flight)
                    storedDeparturesIds.append(d.id)
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
                    self.departures.removeAll()
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as? [AnyObject] else {
                        return
                    }
                    self.departures.appendContentsOf(storedDepartures)
                    for object in jsonArray {
                        let d = object as! [NSObject: AnyObject]
                        if d["departureCode"] as! String == "SZU" && !storedDeparturesIds.contains(Int32(d["id"] as! Int)) {
                            let newFlight = Flight(
                                flightNumber: d["flightNumber"] as! String,
                                departure: d["departure"] as! String,
                                arrival: d["arrival"] as! String,
                                departureCity: d["departureCity"] as! String,
                                departureCode: d["departureCode"] as! String,
                                arrivalCity: d["arrivalCity"] as! String,
                                arrivalCode: d["arrivalCode"] as! String,
                                departureTime: d["departureTime"] as! String,
                                arrivalTime: d["arrivalTime"] as! String,
                                status: d["status"] as! String,
                                checkinDeskNumber: Int32(d["checkinDeskNumber"] as! Int),
                                gateNumber: Int32(d["gateNumber"] as! Int),
                                delay: Int32(d["delay"] as! Int),
                                comment: d["comment"] as! String,
                                id: Int32(d["id"] as! Int),
                                airlineId: d["airlineId"],
                                needSave: false,
                                context: context
                            )
                            self.departures.append(newFlight)
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
}
