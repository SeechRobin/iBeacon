//
//  AppDelegate.m
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "BeaconsTableViewController.h"
#import  <CoreLocation/CoreLocation.h>

@interface AppDelegate ()




@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    NSString *regionIdentifier = @"Estimote Region";
//    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:beaconUUID identifier:regionIdentifier];
//    
//    switch ([CLLocationManager authorizationStatus]) {
//        case kCLAuthorizationStatusAuthorizedAlways:
//            NSLog(@"Authorized Always");
//            break;
//        case kCLAuthorizationStatusAuthorizedWhenInUse:
//            NSLog(@"Authorized when in use");
//            break;
//        case kCLAuthorizationStatusDenied:
//            NSLog(@"Denied");
//            break;
//        case kCLAuthorizationStatusNotDetermined:
//            NSLog(@"Not determined");
//            break;
//        case kCLAuthorizationStatusRestricted:
//            NSLog(@"Restricted");
//            break;
//            
//        default:
//            break;
//    }
//    
//    self.locationManager = [[CLLocationManager alloc] init];
//    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
//        [self.locationManager requestAlwaysAuthorization];
//    }
//    self.locationManager.delegate = self;
//    self.locationManager.pausesLocationUpdatesAutomatically = NO;
//    [self.locationManager startMonitoringForRegion:beaconRegion];
//    [self.locationManager startRangingBeaconsInRegion:beaconRegion];
//    [self.locationManager startUpdatingLocation];
    
    [self.beaconManager requestAlwaysAuthorization];
    self.beaconManager = [[ESTBeaconManager alloc ]init];
    self.beaconManager.delegate = self;

    ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initWithProximityUUID:beaconUUID identifier:regionIdentifier];
    [self.beaconManager startMonitoringForRegion:region];
    [self.beaconManager startRangingBeaconsInRegion:region];
    [self.beaconManager startEstimoteBeaconsDiscoveryForRegion:region]; //CoreBluetooth scanning
    
    
    return YES;
}


//-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
//    [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
//    [self.locationManager startUpdatingLocation];
//    
//    NSLog(@"You entered the region.");
//    [self sendLocalNotificationWithMessage:@"You entered the region."];
//}
//
//-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
//    [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//    [self.locationManager stopUpdatingLocation];
//    
//    NSLog(@"You exited the region.");
//    [self sendLocalNotificationWithMessage:@"You exited the region."];
//}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

//-(void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region {
//    NSString *message = @"";
//    
//    ViewController *viewController = (ViewController*)self.window.rootViewController;
//    viewController.beacons = beacons;
//    [viewController.tableView reloadData];
//    
//    NSLog(@"Number of Beacons in range--> %lu", (unsigned long)beacons.count);
//    if(beacons.count > 0) {
//        CLBeacon *nearestBeacon = beacons.firstObject;
//        if(nearestBeacon.proximity == self.lastProximity ||
//           nearestBeacon.proximity == CLProximityUnknown) {
//            return;
//        }
//        self.lastProximity = nearestBeacon.proximity;
//        
//        switch(nearestBeacon.proximity) {
//            case CLProximityFar:
//                message = @"You are far away from the beacon";
//                break;
//            case CLProximityNear:
//                message = @"You are near the beacon";
//                break;
//            case CLProximityImmediate:
//                message = @"You are in the immediate proximity of the beacon";
//                break;
//            case CLProximityUnknown:
//                return;
//        }
//    } else {
//        message = @"No beacons are nearby";
//    }
//    
//    NSLog(@"%@", message);
//    [self sendLocalNotificationWithMessage:message];
//
//    
//}

-(void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    ViewController *viewController = (ViewController*)self.window.rootViewController;
    viewController.beacons = beacons;
    [viewController.tableView reloadData];
    
    
    NSLog(@"didRangeBeacons!");
    NSString *message = @"Ello!";
    if([beacons count] > 0)
    {
        // beacon array is sorted based on distance
        // closest beacon is the first one
        ESTBeacon* closestBeacon = [beacons objectAtIndex:0];
        
        // calculate and set new y position
        switch (closestBeacon.proximity)
        {
            case CLProximityUnknown:
                message = @"Unknown region";
                break;
            case CLProximityImmediate:
                message = @"Immediate region";
                break;
            case CLProximityNear:
                message = @"Near region";
                break;
            case CLProximityFar:
                message = @"Far region";
                break;
                
            default:
                break;
        }
        
        NSLog(@"Message--> %@", message);
       [self sendLocalNotificationWithMessage:message];
    }
}

#pragma mark - ESTBeaconManager delegate

- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Enter region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(ESTBeaconRegion *)region
{
    UILocalNotification *notification = [UILocalNotification new];
    notification.alertBody = @"Exit region notification";
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
