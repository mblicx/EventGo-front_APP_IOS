//
//  AppDelegate.h
//  EventGo
//
//  Created by ZhangXulong on 16/12/27.
//  Copyright © 2016年 ShuopuLI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@import UserNotifications;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) UNMutableNotificationContent * content;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

