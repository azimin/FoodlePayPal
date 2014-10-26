//
//  FrameCalculation.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

func textWidth(str: NSString, font: UIFont) -> CGFloat {
    var size = CGSizeMake(CGFloat.max, font.pointSize + 2)
    return str.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size.width + 2
}

func textHeight(str: String, font: UIFont, width: CGFloat) -> CGFloat {
    let atributedString = NSAttributedString(string: str, attributes: [NSFontAttributeName: font])
    return attributedTextHeight(atributedString, width)
}

func attributedTextHeight(atrStr: NSAttributedString, width: CGFloat) -> CGFloat {
    var size = CGSizeMake(width - 20, CGFloat.max)
    return atrStr.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height
}

extension UIView {
    
    func pb_takeSnapshot() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.mainScreen().scale);
        
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        
        // old style: self.layer.renderInContext(UIGraphicsGetCurrentContext())
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
}