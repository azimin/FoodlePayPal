//
//  FLRestaurantInfoCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLRestaurantInfoCell: UITableViewCell {

    @IBOutlet weak var restaurantInfo: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .None
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fillWithRestaurant(restaurant: FLRestaurantEntity, tableNumber: Int?) {
        restaurantInfo.text = restaurant.restaurantInfo
        if let tableNum = tableNumber {
            restaurantInfo.text? += "\nYour table number: \(tableNum)"
        }
    }
}
