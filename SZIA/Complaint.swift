//
//  Complaint.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class Complaint: NSObject {
    var name: String
    var email: String
    var subject: String
    var content: String
    
    init(name: String, email: String, subject: String, content: String) {
        self.name = name
        self.email = email
        self.subject = subject
        self.content = content
    }
}
