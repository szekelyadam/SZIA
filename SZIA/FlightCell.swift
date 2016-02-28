//
//  FlightCell.swift
//  SZIA
//
//  Created by Ádibádi on 28/02/16.
//  Copyright © 2016 Székely Ádám. All rights reserved.
//

import UIKit

class FlightCell: UITableViewCell {
    
    @IBOutlet var airlineImageView: UIImageView!
    @IBOutlet var flightNumberLabel: UILabel!
    @IBOutlet var departTimeLabel: UILabel!
    @IBOutlet var infosLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
