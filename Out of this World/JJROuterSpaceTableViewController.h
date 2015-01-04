//
//  JJROuterSpaceTableViewController.h
//  Out of this World
//
//  Created by Justin Russell on 12/17/14.
//  Copyright (c) 2014 Justin Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWAddSpaceObjectViewController.h"

@interface JJROuterSpaceTableViewController : UITableViewController<OWAddSpaceObjectViewControllerDelegate>

@property (strong,nonatomic) NSMutableArray *planets;
@property (strong,nonatomic) NSMutableArray *addedSpaceObejcts;

@end
