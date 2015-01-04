//
//  JJROuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Justin Russell on 12/17/14.
//  Copyright (c) 2014 Justin Russell. All rights reserved.
//

#import "JJROuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "JRSpaceObject.h"
#import "JRSpaceImageViewController.h"
#import "JRSpaceDataViewController.h"

@interface JJROuterSpaceTableViewController ()

@end

@implementation JJROuterSpaceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.planets = [[NSMutableArray alloc] init];
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",planetData[PLANET_NAME]];
        JRSpaceObject *planet = [[JRSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - OWAddSpaceObjectViewController Delegate

-(void)didCancel
{
    NSLog(@"didCancel");
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSpaceObject:(JRSpaceObject *)spaceObject
{
    if(!self.addedSpaceObejcts){
        self.addedSpaceObejcts = [[NSMutableArray alloc] init];
    }
    [self.addedSpaceObejcts addObject:spaceObject];
    NSLog(@"addSpaceObject");
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    if([self.addedSpaceObejcts count]){
        return 2;
    }else{
        return 1;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section == 1){
        return [self.addedSpaceObejcts count];
    }else{
        return [self.planets count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    if(indexPath.section == 1){
        JRSpaceObject *planet = [self.addedSpaceObejcts objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }else{
        JRSpaceObject *planet = [self.planets objectAtIndex:(int)indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickname;
        cell.imageView.image = planet.spaceImage;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([sender isKindOfClass:[UITableViewCell class]])
    {
        if([segue.destinationViewController isKindOfClass:[JRSpaceImageViewController class]])
        {
            JRSpaceImageViewController *nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            JRSpaceObject *selectedObject;
            if(path.section == 0){
                selectedObject = self.planets[path.row];
            }else if(path.section == 1){
                selectedObject = self.addedSpaceObejcts[path.row];
            }
            
            nextViewController.spaceObject = selectedObject;
        }
    }
    if([sender isKindOfClass:[NSIndexPath class]])
    {
        if([segue.destinationViewController isKindOfClass:[JRSpaceDataViewController class]])
        {
            JRSpaceDataViewController *targetViewController = segue.destinationViewController;
            NSIndexPath *path = sender;
            JRSpaceObject *selectedObject;
            if(path.section == 0){
                selectedObject = self.planets[path.row];
            }else if(path.section == 1){
                selectedObject = self.addedSpaceObejcts[path.row];
            }
            targetViewController.spaceObject = selectedObject;
        }
    }
    
    if([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]){
        OWAddSpaceObjectViewController *addSpaceObjectVC = segue.destinationViewController;
        addSpaceObjectVC.delegate = self;
    }
}

#pragma mark UITableView Delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"push to space data" sender:indexPath];
}


@end
