//
//  ViewCircle.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 17/04/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "ViewCircle.h"
#import "UIColor+HexColors.h"

@implementation ViewCircle

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context,[UIColor colorWithHexString:@"2A4D95"].CGColor);
    
    rect.origin.x = rect.origin.x + 4;
    rect.origin.y = rect.origin.y + 4;
    rect.size.width = rect.size.width-8;
    rect.size.height = rect.size.height-8;
    
    CGContextAddEllipseInRect(context, rect);
    CGContextStrokePath(context);
}

@end
