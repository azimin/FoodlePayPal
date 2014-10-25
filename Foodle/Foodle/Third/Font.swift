//
//  Font.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

extension UIColor {
    class func appColor() -> UIColor {
        return UIColor(fromHexString: "31b55c")
    }
    
    class func appColorSelect() -> UIColor {
        return UIColor(fromHexString: "288446")
    }
}

extension UIImage {
    class func imageWithColor(color: UIColor) -> UIImage {
        var rect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image
    }
}
