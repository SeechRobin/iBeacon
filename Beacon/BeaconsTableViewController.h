//
//  BeaconsTableViewController.h
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeaconsTableViewController : UITableViewController
@property IBOutlet UITableView *tableView;
@property (strong) NSArray *beacons;
@end
