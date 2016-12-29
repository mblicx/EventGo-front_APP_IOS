//
//  MapViewController.m
//  UcheckIn
//
//  Created by Alexandre Pestre on 13/05/2015.
//  Copyright (c) 2015 Alexandre Pestre. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface MapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation * locationPlace;
@property (strong, nonatomic) CLLocationManager * locationManager;

@end

// The perimeter of the earth is about 40,000 km
#define EARTH_PERIMETER     4e7

// Convert meters to degrees
#define DEGREES_FROM_M(meters)  (360.0*(meters/EARTH_PERIMETER))

// Radius around the current location when showing this location
#define CURRENT_LOCATION_RADIUS     500


@implementation MapViewController


- (void)viewWillAppear:(BOOL)animated {
    
    _locationManager= [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];
    [self.mapView setDelegate:(id<MKMapViewDelegate>)self];
    [self.mapView setShowsUserLocation:YES];
    


    _locationPlace = [[CLLocation alloc] initWithLatitude:[_event[@"coordinates_y"] doubleValue] longitude:[_event[@"coordinates_x"] doubleValue]];
    MKPointAnnotation * annotation = [[MKPointAnnotation alloc] init];
    annotation.coordinate = _locationPlace.coordinate;
    annotation.title = _event[@"event_name"];
    //annotation.
    NSString * date1 = _event[@"start_date"];
    NSString * date2 = [@"-" stringByAppendingString:_event[@"end_date"]];
    annotation.subtitle = [date1 stringByAppendingString:date2];
    [self scaleMapAroundCoordinate:_locationPlace.coordinate radius:3000];
    _mapView.centerCoordinate = _locationPlace.coordinate;
    
    [_mapView addAnnotation:annotation];
    
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

- (void) scaleMapAroundCoordinate:(CLLocationCoordinate2D)coordinate radius:(double)radius
{
    double widthHeightRatio = self.mapView.bounds.size.width / self.mapView.bounds.size.height;
    
    MKCoordinateSpan span = MKCoordinateSpanMake(DEGREES_FROM_M(radius*widthHeightRatio),
                                                 DEGREES_FROM_M(radius));
    [self.mapView setRegion:MKCoordinateRegionMake(coordinate, span) animated:YES];
}

@end
