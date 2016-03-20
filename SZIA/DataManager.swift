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
    var urlSession: NSURLSession!
    
    override init() {
        airlines = [Airline]()
        
        let url = NSURL(string: "http://szia-backend.herokuapp.com/api/airlines")
        let sessionConfig = NSURLSessionConfiguration.defaultSessionConfiguration()
        urlSession = NSURLSession(configuration: sessionConfig, delegate: nil, delegateQueue: NSOperationQueue.mainQueue())
        
        super.init()
        
        let dataTask = urlSession.dataTaskWithURL(url!, completionHandler: { data, response, error in
            
            if data != nil {
                do {
                    self.airlines.removeAll()
                    guard let jsonArray = try NSJSONSerialization.JSONObjectWithData(data!,
                        options: NSJSONReadingOptions(rawValue: 0)) as? [AnyObject] else {
                            return
                    }
                    for object in jsonArray {
                        let d = object as! [NSObject: AnyObject]
                        let airline = Airline(id: d["id"] as! Int32, name: d["name"] as! String, imageURL: d["imageURL"] as! String, airlineCode: d["airlineCode"] as! String)
                        self.airlines.append(airline)
                    }
                } catch {
                    print("Error \(error)")
                }
            }
        })
        dataTask.resume()
    }

}
