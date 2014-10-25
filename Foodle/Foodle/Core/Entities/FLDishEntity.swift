//
//  FLDishEntity.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

class FLDishEntity: NSObject {
    var dishName = ""
    var dishDescription = ""
    var dishImageURL = ""
    var dishPrice: CGFloat = 0.0
    var dishPriority = 0
    var dishCategory = ""
    var count = 0
    
    override init() {
        
    }
    
    init(dishName: String, dishDescription: String, dishImageURL: String, dishPrice: CGFloat, dishCategory: String) {
        self.dishName = dishName
        self.dishDescription = dishDescription
        self.dishImageURL = dishImageURL
        self.dishPrice = dishPrice
        self.dishCategory = dishCategory
    }
    
    class func filterDishes(dishes: [FLDishEntity]) -> [String: [FLDishEntity]] {
        var result: [String: [FLDishEntity]] = [:]
        for el in dishes {
            if (result[el.dishCategory] == nil) {
                result[el.dishCategory] = [el]
            } else {
                result[el.dishCategory]?.append(el)
            }
        }
        
        return result
    }
}
