//
//  FLRestaurantsHolder.swift
//  Foodle
//
//  Created by Nikolay Pestrov on 26.10.14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLModelHolder: NSObject {
	
	var restaurants : [FLModelHolder] = []
	
	class var sharedInstance :FLModelHolder {
		struct Singleton {
			static let instance = FLModelHolder()
		}
		return Singleton.instance
	}
}
