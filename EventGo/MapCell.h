//
//  MapCell.h
//  EventGo
//
//  Created by ZhangXulong on 16/12/29.
//  Copyright © 2016年 ShuopuLI. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GenericViewController.h"


@interface MapCell : MKPointAnnotation

@property (nonatomic,strong) NSDictionary * event;

@end
