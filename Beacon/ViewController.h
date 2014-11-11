//
//  ViewController.h
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GraphKit.h"

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, GKBarGraphDataSource>

@property IBOutlet UITableView *tableView;
@property (strong) NSArray *beacons;

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *labels;

@property (strong, nonatomic) IBOutlet GKBarGraph *graphV;



@end

