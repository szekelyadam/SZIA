//
//  News.swift
//  SZIA
//
//  Created by Ádibádi on 27/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class News: NSObject {
    var date: NSDate?
    var title: String
    var content: String
    
    init(date: String, title: String, content: String) {
        self.title = title
        self.content = content
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.date = dateFormatter.dateFromString(date)
    }
}
