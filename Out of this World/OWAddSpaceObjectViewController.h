//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by Justin Russell on 1/2/15.
//  Copyright (c) 2015 Justin Russell. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRSpaceObject.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>

@required

-(void)addSpaceObject:(JRSpaceObject *)spaceObject;
-(void)didCancel;

@end

@interface OWAddSpaceObjectViewController : UIViewController

@property (weak,nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *nicknameTextField;
@property (strong, nonatomic) IBOutlet UITextField *diameterTextField;
@property (strong, nonatomic) IBOutlet UITextField *temperatureTextField;
@property (strong, nonatomic) IBOutlet UITextField *numberOfMoonsTextField;
@property (strong, nonatomic) IBOutlet UITextField *interestingFactTextField;

- (IBAction)addButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;

@end
