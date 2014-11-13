//
//  ViewController.m
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import "ViewController.h"
#import "BeaconTableViewCell.h"
#import  <CoreLocation/CoreLocation.h>
#import "ESTBeacon.h"
#import "AppDelegate.h"


@interface ViewController ()

@end

@implementation ViewController

static ESTBeaconRegion *region;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSUUID *beaconUUID = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    NSString *regionIdentifier = @"Estimote Region";
    
    self.locationManager = [[CLLocationManager alloc] init];
    if([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    
    
    //    if([self.beaconManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
    //        [self.beaconManager requestAlwaysAuthorization];
    //    }
    
    [self.beaconManager requestAlwaysAuthorization]; //always on, bad for the batters
    [self.beaconManager requestWhenInUseAuthorization]; // better option
    
    self.beaconManager = [[ESTBeaconManager alloc ]init];
    self.beaconManager.delegate = self;
    
    ESTBeaconRegion *region = [[ESTBeaconRegion alloc] initWithProximityUUID:beaconUUID identifier:regionIdentifier];
    [self.beaconManager startMonitoringForRegion:region];
    [self.beaconManager startRangingBeaconsInRegion:region];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewController
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beacons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        cell = [[BeaconTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.selectionStyle = UITableViewCellAccessoryCheckmark;
    }
    
    ESTBeacon *beacon = (ESTBeacon*)[self.beacons objectAtIndex:indexPath.row];
    NSString *proximityLabel = @"";
    switch (beacon.proximity) {
        case CLProximityFar:
            proximityLabel = @"Far";
            break;
        case CLProximityNear:
            proximityLabel = @"Near";
            break;
        case CLProximityImmediate:
            proximityLabel = @"Immediate";
            break;
        case CLProximityUnknown:
            proximityLabel = @"Unknown";
            break;
    }
    
   cell.proximityLabel.text = proximityLabel;
   cell.majorLabel.text = [NSString stringWithFormat:@"%ld", (long)beacon.major.integerValue];
   cell.minorLabel.text = [NSString stringWithFormat:@"%ld", (long)beacon.minor.integerValue];
   cell.accuraryLabel.text = [NSString stringWithFormat:@"%@", beacon.distance];
   cell.sstrengthLabel.text = [NSString stringWithFormat:@"%ld dB", (long)beacon.rssi ];
   cell.uuidLabel.text = [NSString stringWithFormat:@"%@", beacon.proximityUUID.UUIDString];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
}





#pragma mark - ESTBeaconManager delegate

-(void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(ESTBeaconRegion *)region
{
    
    self.beacons = beacons;
    [self.tableView reloadData];
    
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


#pragma mark - UISegmentedControl
- (IBAction)segmentSwitch:(id)sender {
    
   
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    if (selectedSegment == 0) {
        NSLog(@"Segment 0");
        [self.beaconManager stopMonitoringForRegion:region];
        [self.beaconManager stopRangingBeaconsInRegion:region]; //stop ranging beacons
    }
    else{
        NSLog(@"Segment 1");
    }
}

#pragma mark - Helpers!

float roundToN(float num, int decimals)
{
    int tenpow = 1;
    for (; decimals; tenpow *= 10, decimals--);
    return round(tenpow * num) / tenpow;
}

-(void)sendLocalNotificationWithMessage:(NSString*)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}
@end
