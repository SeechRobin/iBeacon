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
#import "GraphKit.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.data = @[@70];
    self.labels = @[@"dB"];
    

    //[self.graphV setDataSource:self];
   // self.graphV.dataSource = self;
    //[self.graphV draw];

}

#pragma mark - GKBarGraphDataSource

- (NSInteger)numberOfBars {
    return [self.data count];
}

- (NSNumber *)valueForBarAtIndex:(NSInteger)index {
    return [self.data objectAtIndex:index];
}

- (UIColor *)colorForBarAtIndex:(NSInteger)index {
    id colors = @[[UIColor gk_turquoiseColor]
                  ];
    return [colors objectAtIndex:index];
}

//- (UIColor *)colorForBarBackgroundAtIndex:(NSInteger)index {
//    return [UIColor redColor];
//}

- (NSString *)titleForBarAtIndex:(NSInteger)index {
    NSLog(@"Getting title for bars");
    return [self.labels objectAtIndex:index];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.beacons.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BeaconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyIdentifier"];
    
    if (cell == nil) {
        cell = [[BeaconTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
   
   // cell.backgroundColor = [UIColor gk_turquoiseColor];
    
   cell.proximityLabel.text = proximityLabel;
   cell.majorLabel.text = [NSString stringWithFormat:@"%ld", (long)beacon.major.integerValue];
   cell.minorLabel.text = [NSString stringWithFormat:@"%ld", (long)beacon.minor.integerValue];
   //cell.accuraryLabel.text = [NSString stringWithFormat:@"%f", roundToN([beacon.distance floatValue], 2)];
   cell.accuraryLabel.text = [NSString stringWithFormat:@"%@", beacon.distance];
   cell.sstrengthLabel.text = [NSString stringWithFormat:@"%ld dB", (long)beacon.rssi ];

    
   //cell.textLabel.text = proximityLabel;
//
//    NSString *detailLabel = [NSString stringWithFormat:@"Accuracy: %f Major: %d, Minor: %d, RSSI: %d, UUID: %@",
//                             beacon.accuracy,beacon.major.intValue, beacon.minor.intValue, (int)beacon.rssi, beacon.proximityUUID.UUIDString];
//    cell.detailTextLabel.text = detailLabel;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld", (long)indexPath.row);
}

float roundToN(float num, int decimals)
{
    int tenpow = 1;
    for (; decimals; tenpow *= 10, decimals--);
    return round(tenpow * num) / tenpow;
}

@end
