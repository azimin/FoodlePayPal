//
//  FLPreferenceEntity.swift
//  Foodle
//
//  Created by Alex Zimin on 26/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLPreferenceEntity: NSObject {
    var name = ""
    var count = 0
    
    override init() {
        
    }
    
    init(name: String, count: Int) {
        self.name = name
        self.count = count
    }
}
