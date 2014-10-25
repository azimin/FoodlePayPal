//
//  FLRestaurantPayCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLRestaurantPayCell: UITableViewCell {

    @IBOutlet weak var billLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        billLabel.textColor = UIColor.appColor()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
