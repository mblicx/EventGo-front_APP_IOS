//
//  HomeMapViewController.m
//  UcheckIn
//
//  Created by Stimshop-MacDev on 10/05/2016.
//  Copyright © 2016 Alexandre Pestre Conseil et Edition. All rights reserved.
//

#import "HomeMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "MapCell.h"
#import "DetailPlaceViewController.h"
@interface HomeMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocation * locationPlace;
@property (strong, nonatomic) CLLocationManager * locationManager;

@end

// The perimeter of the earth is about 40,000 km
#define EARTH_PERIMETER     4e7

// Convert meters to degrees
#define DEGREES_FROM_M(meters)  (360.0*(meters/EARTH_PERIMETER))

#define CURRENT_LOCATION_RADIUS     20000


@implementation HomeMapViewController

- (void)viewWillAppear:(BOOL)animated {
    
    
    
    _locationManager= [[CLLocationManager alloc] init];
    [_locationManager requestAlwaysAuthorization];
    [self.mapView setDelegate:(id<MKMapViewDelegate>)self];
    [self.mapView setRegion:MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(48.8390349,2.3745759), CURRENT_LOCATION_RADIUS, CURRENT_LOCATION_RADIUS) animated:YES];

    for(NSDictionary * event in _arrayOfEvents)
    {
        _locationPlace = [[CLLocation alloc] initWithLatitude:[event[@"coordinates_y"] doubleValue] longitude:[event[@"coordinates_x"] doubleValue]];
        MapCell * annotation = [[MapCell alloc] init];
        annotation.coordinate = _locationPlace.coordinate;
        annotation.title = event[@"event_name"];
        //annotation.
        annotation.event = event;
        NSString * date1 = event[@"start_date"];
        NSString * date2 = [@"-" stringByAppendingString:event[@"end_date"]];
        annotation.subtitle = [date1 stringByAppendingString:date2];
        [_mapView addAnnotation:annotation];
    }

}
-(void)showDetailsView{
    
    NSLog(@"detail");
}
-(void)mapView:(MKMapView *)mapView annotationView:(MKPinAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    MapCell * annotation =view.annotation;
    NSLog(@"%@",annotation.title);
    [self performSegueWithIdentifier:@"detailEvent" sender:view];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView *)sender
{
    if ([segue.identifier isEqualToString:@"detailEvent"])
    {
        DetailPlaceViewController * detailView = segue.destinationViewController;
        
        // grab the annotation from the sender
        MapCell * annotation = sender.annotation;
        detailView.event = annotation.event;
    } else {
        NSLog(@"PFS:something else");
    }
}


- (MKPinAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if ([[annotation title] isEqualToString:@"Current Location"]) {
        return nil;
    }
    MKPinAnnotationView *annView = [[MKPinAnnotationView alloc ] initWithAnnotation:annotation reuseIdentifier:NULL];
    UIImageView * icon =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, annView.frame.size.height, annView.frame.size.height)];
    icon.image=[UIImage imageNamed:@"logo.png"];
    annView.leftCalloutAccessoryView = icon;
    UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [infoButton addTarget:self action:@selector(showDetailsView)
         forControlEvents:UIControlEventTouchUpInside];
    annView.rightCalloutAccessoryView = infoButton;
    annView.canShowCallout = YES;
    return annView;
}


@end
