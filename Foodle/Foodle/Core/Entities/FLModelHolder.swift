//
//  FLRestaurantsHolder.swift
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLModelHolder: NSObject {
	
	var restaurants : [FLRestaurantEntity] = []
	
	var activeUsers : [FLUserEntity] = []
	var currentUser : FLUserEntity?
	var orderedDishes: [FLDishEntity] = []
	class var sharedInstance :FLModelHolder {
		struct Singleton {
			static let instance = FLModelHolder()
		}
		return Singleton.instance
	}
	override init() {
		
	}
}
