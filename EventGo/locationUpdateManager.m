//
//  locationUpdateManager.m
//  EventGo
//
//  Created by ZhangXulong on 16/12/30.
//  Copyright © 2016年 ShuopuLI. All rights reserved.
//

#import "locationUpdateManager.h"

@interface locationUpdateManager() <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *standardlocationManager;
@property (strong, nonatomic) NSDate *lastTimestamp;
@property (nonatomic) BOOL isScanning;
@property (strong, nonatomic) NSArray * eventArray;
@end

@implementation locationUpdateManager
# pragma mark - StandardManager
+ (instancetype)sharedStandardManager
{
    static locationUpdateManager* sharedStandardInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedStandardInstance = [[self alloc]initStandard];
        sharedStandardInstance.isScanning=NO;
        sharedStandardInstance.eventArray=nil;
        sharedStandardInstance.findArray = [[NSMutableArray alloc] init];
        sharedStandardInstance.clickedArray = [[NSMutableArray alloc] init];
        sharedStandardInstance.content = [[UNMutableNotificationContent alloc] init];

    });
    return sharedStandardInstance;
}

- (id)initStandard
{
    if (self = [super init])
    {
        // 初始化工作
        self.standardlocationManager = [[CLLocationManager alloc]init];
        self.standardlocationManager.desiredAccuracy = kCLLocationAccuracyBest; //kCLLocationAccuracyHundredMeters better battery life
        self.standardlocationManager.delegate = self;
        self.standardlocationManager.pausesLocationUpdatesAutomatically = NO; // this is important
        self.standardlocationManager.distanceFilter = 20;//距离过滤
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8) {
            [self.standardlocationManager requestAlwaysAuthorization];//在后台也可定位
        }
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9) {
            self.standardlocationManager.allowsBackgroundLocationUpdates = YES;
        }
    }
    return self;
}
- (void)updateEventArray:(NSArray *) array
{
    _eventArray=array;
}
- (void)startStandardUpdatingLocation
{
    NSLog(@"startStandardUpdatingLocation");
    [self.standardlocationManager startUpdatingLocation];
    _isScanning=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"startScanning" object:nil];

}

- (void)stopStandardUpdatingLocation
{
    NSLog(@"stopStandardUpdatingLocation");
    [self.standardlocationManager stopUpdatingLocation];
    _isScanning=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"stopScanning" object:nil];
}

- (BOOL)isScanning
{
    return _isScanning;
}

#pragma mark - 定位代理函数
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *mostRecentLocation = locations.lastObject;
    //通过socket webservice等上传定位信息mostRecentLocation
    if (mostRecentLocation.horizontalAccuracy < 0)
        return;
    CLLocationCoordinate2D coordinate = mostRecentLocation.coordinate;
    CGFloat longitude = coordinate.longitude;
    CGFloat latitude = coordinate.latitude;
    NSLog(@"经度:%f,纬度:%f",longitude,latitude);
    if(_eventArray!=nil)
    {
        for(NSDictionary * event in _eventArray)
        {
            CLLocation * location=[[CLLocation alloc] initWithLatitude:[event[@"coordinates_y"] doubleValue] longitude:[event[@"coordinates_x"] doubleValue]];
            CLLocation *current=[[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
            CLLocationDistance meters=[current distanceFromLocation:location];
            if(meters<=1000)
            {
                
                if(_findArray.count>0)
                {
                    for(NSDictionary * eventNoti in _findArray)
                    {
                        if([eventNoti[@"event_id"] isEqualToValue:event[@"event_id"]])
                            return;
                    }
                }
                [_findArray addObject:event];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"badge" object:nil];
                _content.title = [NSString localizedUserNotificationStringForKey:@"Event Nearby:" arguments:nil];
                _content.body = [NSString localizedUserNotificationStringForKey:@"Hello！We find an Event nearby, come have a look, maybe you are interst in!"
                                                                      arguments:nil];
                _content.sound = [UNNotificationSound defaultSound];
                
                /// 4. update application icon badge number
                _content.badge = @([[locationUpdateManager sharedStandardManager]findArray].count-[[locationUpdateManager sharedStandardManager]clickedArray].count);
                // Deliver the notification in five seconds.
                UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger
                                                              triggerWithTimeInterval:5.f repeats:NO];
                UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"FiveSecond"
                                                                                      content:_content trigger:trigger];
                /// 3. schedule localNotification
                UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
                [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    if (!error) {
                        NSLog(@"add NotificationRequest succeeded!");
                    }
                }];
                

            }
        }
    }
}
@end
