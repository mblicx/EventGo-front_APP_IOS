//
//  EventCell.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 12/05/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "EventCell.h"

@implementation EventCell


- (void) drawRect:(CGRect)rect {

    CALayer* layer = [CALayer layer];
    layer.backgroundColor = [[UIColor blackColor] CGColor];
    
    CGPoint point = _img_event.center;
    point.x = point.x + 1;
    point.y = point.y + 1;
    
    layer.position = point; 
    layer.bounds = CGRectMake(0,0,self.img_event.frame.size.width/1.2,self.img_event.frame.size.width/1.2);
    layer.cornerRadius = self.img_event.frame.size.width/2.4;
    self.img_event.layer.mask = layer;
    

//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(self.img_event.frame.origin.x, self.img_event.frame.origin.y-10, self.img_event.frame.size.width-20, self.img_event.frame.size.height-20) cornerRadius:self.img_event.frame.size.width-20/2];
//    maskLayer.fillColor = [[UIColor whiteColor] CGColor];
//    maskLayer.backgroundColor = [[UIColor whiteColor] CGColor];
//    maskLayer.path = [roundedPath CGPath];
//    
//    // Add mask
//    self.img_event.layer.mask = maskLayer;
}



@end
