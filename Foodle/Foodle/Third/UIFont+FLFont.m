//
//  UIFont+FLFont.m
//  Foodle
//
//  Created by Alex Zimin on 25/10/14.
//  Copyright (c) 2014 Foodlle. All rights reserved.
//

#import "UIFont+FLFont.h"

@implementation UIFont (FLFont)

+ (UIFont*)mainFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNext-Medium" size:size];
}

+ (UIFont*)mainBoldFontWithSize:(CGFloat)size {
    return [UIFont fontWithName:@"AvenirNext-Bold" size:size];
}

@end
