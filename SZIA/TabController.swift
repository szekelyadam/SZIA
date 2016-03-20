//
//  TabController.swift
//  SZIA
//
//  Created by Ádibádi on 20/03/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class TabController: UITabBarController {
    
    @IBOutlet weak var tabs: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let landingPlaceIcon = UIImage.fontAwesomeIconWithName(.Plane, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        
        tabs.items![0].image = UIImage.fontAwesomeIconWithName(.Plane, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        tabs.items![1].image = UIImage(CGImage: landingPlaceIcon.CGImage! , scale: landingPlaceIcon.scale, orientation: .Right)
        tabs.items![2].image = UIImage.fontAwesomeIconWithName(.NewspaperO , textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        tabs.items![3].image = UIImage.fontAwesomeIconWithName(.MapO , textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
        tabs.items![4].image = UIImage.fontAwesomeIconWithName(.CommentO , textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
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
