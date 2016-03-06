//
//  MapViewController.swift
//  SZIA
//
//  Created by Ádibádi on 06/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let coordinate = CLLocationCoordinate2D(latitude: 47.473424, longitude: 19.059899)
        let annotation = AirportAnnotation(coordinate: coordinate, title: "South-Zubony International Airport", subtitle: "Itt van a reptér, tutira. A Google hazudik.")
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
