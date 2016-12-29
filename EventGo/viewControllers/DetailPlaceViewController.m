//
//  DetailPlaceViewController.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 14/04/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//


#import "DetailPlaceViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MapViewController.h"
#import "UIKit+AFNetworking.h"
#import "constants.h"

@interface DetailPlaceViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lbl_longDescription;
@property (weak, nonatomic) IBOutlet UIImageView *img_place;
@property (weak, nonatomic) IBOutlet UILabel *lbl_eventName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_debutEvent;
@property (weak, nonatomic) IBOutlet UILabel *lbl_finEvent;
@property (weak, nonatomic) IBOutlet UIButton *btn_favoris;
@property (strong, nonatomic)  NSString *eventName;
@property (weak, nonatomic) IBOutlet UILabel *lbl_lieu;
@property (weak, nonatomic) IBOutlet UILabel *lbl_shortDescription;
@property (weak, nonatomic) IBOutlet UIWebView *web_longDescription;
@property (weak, nonatomic) IBOutlet UIView *view_description;
@property (weak, nonatomic) IBOutlet UIView *view_topBar;

@end

@implementation DetailPlaceViewController



- (void)viewWillAppear:(BOOL)animated {

//    if ([[UcheckinManager sharedManager] isScanning]) {
//    
//        _view_topBar.backgroundColor = [UIColor colorWithRed:Yellow_red green:Yellow_green blue:Yellow_blue alpha:1.0];
//    }
//    else {
        _view_topBar.backgroundColor = [UIColor colorWithRed:Green_red green:Green_green blue:Green_blue alpha:1.0];
//
//    }

    _lbl_eventName.text = [_event[@"event_name"] uppercaseString];
    _lbl_shortDescription.text = [_event[@"description"] uppercaseString];
    [_web_longDescription loadHTMLString: _event[@"LongDescription"]?:_event[@"description"] baseURL:nil];
    _lbl_lieu.text = _event[@"address"];
//    if([[_event[@"favoris"] lowercaseString] isEqual: @"yes"])
//        _btn_favoris.selected=true;
//    else
        _btn_favoris.selected=false;

    
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    NSString * date1 = [@"From: " stringByAppendingString:_event[@"start_date"]];
    NSString * date2 = [@"To: " stringByAppendingString:_event[@"end_date"]];

    
    _lbl_debutEvent.text = date1;
    _lbl_finEvent.text = date2;
    
    [_img_place setImageWithURL:[NSURL URLWithString:_event[@"imageurl"]]];
    UIImage *bgImg1 = [UIImage imageNamed:@"ic_favorite_white_48pt.png"];
    UIImage *bgImg2 = [UIImage imageNamed:@"ic_favorite_border_white_48pt.png"];
    [_btn_favoris setBackgroundImage:bgImg2 forState:UIControlStateNormal];
    [_btn_favoris setBackgroundImage:bgImg1 forState:UIControlStateSelected];
    
}
- (IBAction)mapButton:(UIButton *)sender {
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake([_event[@"coordinates_y"] doubleValue] , [_event[@"coordinates_x"] doubleValue] ) addressDictionary:nil];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    [mapItem setName:_event[@"address"]];
    
    NSDictionary *options = @{
                              MKLaunchOptionsDirectionsModeKey:
                                  MKLaunchOptionsDirectionsModeWalking,
                              MKLaunchOptionsMapTypeKey:
                                  [NSNumber numberWithInteger:MKMapTypeStandard],
                              MKLaunchOptionsShowsTrafficKey:@NO
                              };
    
    [mapItem openInMapsWithLaunchOptions:options];
    
}
//
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//
//    if ([segue.identifier isEqualToString:@"map"]) {//rm here do test
//    
//        MapViewController * mapViewController = (MapViewController*)segue.destinationViewController;
//        mapViewController.event = _event;
//        [mapViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
//    
//    }
//
//}

- (IBAction)actionFavoris:(UIButton *)sender {
//    if([[_event[@"favoris"] lowercaseString] isEqual: @"yes"])
//    {
//        [_event setValue:@"no" forKey:@"favoris"];
//        sender.selected=false;
//    }
//    else{
//        [_event setValue:@"yes" forKey:@"favoris"];
//        sender.selected=true;
//
//    }
}
@end
