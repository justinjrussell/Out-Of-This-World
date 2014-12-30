//
//  JRSpaceDataViewController.h
//  Out of this World
//
//  Created by Justin Russell on 12/30/14.
//  Copyright (c) 2014 Justin Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRSpaceObject.h"

@interface JRSpaceDataViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) JRSpaceObject *spaceObject;

@end
