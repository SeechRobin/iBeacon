//
//  BeaconTableViewCell.h
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BeaconTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *minorLabel;
@property (strong, nonatomic) IBOutlet UILabel *proximityLabel;
@property (strong, nonatomic) IBOutlet UILabel *accuraryLabel;
@property (strong, nonatomic) IBOutlet UILabel *sstrengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *uuidLabel;



@end
