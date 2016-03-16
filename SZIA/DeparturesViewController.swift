//
//  DeparturesViewController.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class DeparturesViewController: UITableViewController {
    
    var departures = [Flight]()
    var urlSession : NSURLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        self.loadDepartures()
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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.departures.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FlightCell = tableView.dequeueReusableCellWithIdentifier("DeparturesTableViewCell", forIndexPath: indexPath) as! FlightCell
    
        let departureData = departures[indexPath.row] as Flight
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        cell.flightNumberLabel.text = "\(departureData.departureCode) -> \(departureData.arrivalCode) - \(departureData.flightNumber)"
        cell.timeLabel.text = dateFormatter.stringFromDate(departureData.departureTime!)
        cell.infosLabel.text = departureData.comment
        cell.airlineImageView.image = departureData.getAirline()!.logo!
        
        return cell
    }
    
    func loadDepartures() {
        let url = NSURL(string: "http://szia-backend.herokuapp.com/api/flights")
        let dataTask = urlSession.dataTaskWithURL(url!, completionHandler: {
            data, response, error in
            
                do {
                    self.departures.removeAll()
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: NSJSONReadingOptions(rawValue: 0)) as? [AnyObject] else {
                        return
                    }
                    for object in jsonArray {
                        let d = object as! [NSObject: AnyObject]
                        if d["departureCode"] as! String == "SZU" {
                            let flight = Flight(flightNumber: d["flightNumber"] as! String, departure: d["departure"] as! String, arrival: d["arrival"] as! String, departureCity: d["departureCity"] as! String, departureCode: d["departureCode"] as! String, arrivalCity: d["arrivalCity"] as! String, arrivalCode: d["arrivalCode"] as! String, departureTime: d["departureTime"] as! String, arrivalTime: d["arrivalTime"] as! String, status: d["status"] as! String, checkinDeskNumber: d["checkinDeskNumber"] as! Int, gateNumber: d["gateNumber"] as! Int, delay: d["delay"] as! Int, comment: d["comment"] as! String, id: 1, airlineId: 1)
                            self.departures.append(flight)
                        }
                    }
                } catch {
                    print("Error \(error)")
                }
            })
        dataTask.resume()
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
