//
//  FLRestaurantCell.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLRestaurantCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var stateIconImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIView!
    
    private var restaurant: FLRestaurantEntity?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        restaurantImage.image = nil
    }
    
    func fillWithRestaurant(restaurant: FLRestaurantEntity) {
        nameLabel.text = restaurant.restaurantName
        descriptionLabel.text = restaurant.restaurantDescription
        //recomendationsLabel.text = "sadjsajk jksad jksaj djas jkdjkas jdksa jkdjkajks djsa djkasjkd"
        
        if restaurant.isIBecacon {
            stateIconImage.image = UIImage(named: "bluetoothIcon")
        } else {
            stateIconImage.image = UIImage(named: "mapIcon")
        }
        
        self.restaurant = restaurant
        
        restaurantImage.image = UIImage(named: restaurant.restaurantImageURL)
        backgroundImage.backgroundColor = UIColor.blackColor()
        backgroundImage.alpha = 0.4
    }
    
    
    func showImage(show: Bool) {
//        if (show && restaurant != nil) {
//            restaurantImage.image = UIImage(named: restaurant!.restaurantImageURL)
//            backgroundImage.backgroundColor = UIColor.blackColor()
//            backgroundImage.alpha = 0.4
//        } else {
//            backgroundImage.backgroundColor = UIColor(fromHexString: "a0b6a7")
//            backgroundImage.alpha = 1.0
//        }
    }
    
}
