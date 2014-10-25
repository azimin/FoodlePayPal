//
//  FLRestaurantEntity.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLRestaurantEntity: NSObject {
    var restaurantName = ""
    var restaurantDescription = ""
    var restaurantInfo = ""
    
    var restaurantImageURL = ""
    
    var restaurantRange = 0.0
    var restaurantRecommends: [String] = []
    var isIBecacon = false
    
    
    override init() {
        
    }
    
    init(restaurantName: String, restaurantDescription: String, isIBecacon: Bool, restaurantImageURL: String) {
        self.restaurantName = restaurantName
        self.restaurantDescription = restaurantDescription
        self.isIBecacon = isIBecacon
        self.restaurantImageURL = restaurantImageURL
        self.restaurantInfo = restaurantDescription
    }
}
