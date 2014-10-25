//
//  FrameCalculation.swift
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

import UIKit

func textHeight(str: String, font: UIFont, width: CGFloat) -> CGFloat {
    let atributedString = NSAttributedString(string: str, attributes: [NSFontAttributeName: font])
    return attributedTextHeight(atributedString, width)
}

func attributedTextHeight(atrStr: NSAttributedString, width: CGFloat) -> CGFloat {
    var size = CGSizeMake(width - 20, CGFloat.max)
    return atrStr.boundingRectWithSize(size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, context: nil).size.height
}