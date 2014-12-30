//
//  JRSpaceImageViewController.h
//  Out of this World
//
//  Created by Justin Russell on 12/26/14.
//  Copyright (c) 2014 Justin Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRSpaceObject.h"

@interface JRSpaceImageViewController : UIViewController <UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *imageView;
@property (strong,nonatomic) JRSpaceObject *spaceObject;

@end
