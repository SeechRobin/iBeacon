//
//  ViewController.h
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ESTBeaconManager.h>
#import <ESTBeaconRegion.h>


@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate, ESTBeaconDelegate, ESTBeaconManagerDelegate>


@property (strong, nonatomic) CLLocationManager *locationManager;
@property CLProximity lastProximity;

@property (nonatomic, strong) ESTBeacon        *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) ESTBeaconRegion  *beaconRegion;

@property (strong) NSArray *beacons;
@property IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISegmentedControl *stateButton;
@property (strong, nonatomic) IBOutlet UIButton *getMessagesButton;

- (IBAction)segmentSwitch:(id)sender;


@end

