//
//  OWAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by Justin Russell on 1/2/15.
//  Copyright (c) 2015 Justin Russell. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *orionImage = [UIImage imageNamed:@"Orion.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:orionImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addButtonPressed:(UIButton *)sender
{
    JRSpaceObject *newSpaceObject = [self returnNewSpaceObject];
    [self.delegate addSpaceObject:newSpaceObject];
}

- (IBAction)cancelButtonPressed:(UIButton *)sender
{
    [self.delegate didCancel];
}

-(JRSpaceObject *)returnNewSpaceObject
{
    JRSpaceObject *spaceObejct = [[JRSpaceObject alloc] init];
    spaceObejct.name = self.nameTextField.text;
    spaceObejct.nickname = self.nicknameTextField.text;
    spaceObejct.diameter = [self.diameterTextField.text floatValue];
    spaceObejct.temperature = [self.temperatureTextField.text floatValue];
    spaceObejct.numberOfMoons = [self.numberOfMoonsTextField.text intValue];
    spaceObejct.interestFact = self.interestingFactTextField.text;
    spaceObejct.spaceImage = [UIImage imageNamed:@"EinsteinRing.jpg"];
    
    return spaceObejct;
}

@end
