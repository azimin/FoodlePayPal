//
//  FLUserEntity.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLUserEntity: NSObject {
    var userName = ""
    var userBill: CGFloat = 0.0
    var userNewDishes = 0
    var userTable = 0
    
    override init() {
        
    }
    
    init(userName: String, userBill: CGFloat, userNewDishes: Int, userTable: Int) {
        self.userName = userName
        self.userBill = userBill
        self.userNewDishes = userNewDishes
        self.userTable = userTable
    }
}
