//
//  BeaconTableViewCell.m
//  Beacon
//
//  Created by Robin Mukanganise on 2014/11/07.
//  Copyright (c) 2014 Grapevine Interactive. All rights reserved.
//

#import "BeaconTableViewCell.h"

@implementation BeaconTableViewCell
@synthesize majorLabel = _majorLabel;
@synthesize minorLabel = _minorLabel;
@synthesize accuraryLabel = _accuraryLabel;
@synthesize proximityLabel = _proximityLabel;
//@synthesize sstrengthLabel = _sstrengthLabel;
@synthesize graphView = _graphView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
