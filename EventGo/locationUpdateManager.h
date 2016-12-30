#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManager.h>
@import UserNotifications;

@interface locationUpdateManager:NSObject<CLLocationManagerDelegate>
@property (strong, nonatomic) NSMutableArray * findArray;
@property (strong, nonatomic) NSMutableArray * clickedArray;
@property(nonatomic, strong) UNMutableNotificationContent *content;


+ (instancetype)sharedStandardManager;
- (void)updateEventArray:(NSArray *) array;
- (void)startStandardUpdatingLocation;
- (void)stopStandardUpdatingLocation;
- (BOOL)isScanning;
@end
