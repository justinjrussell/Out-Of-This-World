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
#define ADDED_SPACE_OBJECTS_KEY @"Added Space Object Array"

#pragma mark - Lazy Instantiation of Properties

-(NSMutableArray *)planets
{
    if(!_planets){
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

-(NSMutableArray *)addedSpaceObejcts
{
    if(!_addedSpaceObejcts){
        _addedSpaceObejcts = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObejcts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSMutableDictionary *planetData in [AstronomicalData allKnownPlanets]) {
        NSString *imageName = [NSString stringWithFormat:@"%@.jpg",planetData[PLANET_NAME]];
        JRSpaceObject *planet = [[JRSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imageName]];
        [self.planets addObject:planet];
    }
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY];
    for (NSDictionary *dictionary in myPlanetsAsPropertyLists) {
        JRSpaceObject *spaceObject = [self spaceObjectForDictionary:dictionary];
        [self.addedSpaceObejcts addObject:spaceObject];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - OWAddSpaceObjectViewController Delegate

-(void)didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)addSpaceObject:(JRSpaceObject *)spaceObject
{
    [self.addedSpaceObejcts addObject:spaceObject];
    
    //Will save to NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_SPACE_OBJECTS_KEY] mutableCopy];
    if(!spaceObjectsAsPropertyLists) spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObject]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:ADDED_SPACE_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self.tableView reloadData];
}

#pragma mark - Helper Methods

-(NSDictionary *)spaceObjectAsAPropertyList:(JRSpaceObject *)spaceObject
{
    NSData *imageData = UIImagePNGRepresentation(spaceObject.spaceImage);
    NSDictionary *dictionary = @{PLANET_NAME: spaceObject.name,
                                 PLANET_GRAVITY: @(spaceObject.gravitationalForce),
                                 PLANET_DIAMETER: @(spaceObject.diameter),
                                 PLANET_YEAR_LENGTH: @(spaceObject.yearLength),
                                 PLANET_DAY_LENGTH: @(spaceObject.dayLength),
                                 PLANET_TEMPERATURE: @(spaceObject.temperature),
                                 PLANET_NUMBER_OF_MOONS: @(spaceObject.numberOfMoons),
                                 PLANET_NICKNAME: spaceObject.nickname,
                                 PLANET_INTERESTING_FACT: spaceObject.interestFact,
                                 PLANET_IMAGE: imageData};
    return dictionary;
}

-(JRSpaceObject *)spaceObjectForDictionary:(NSDictionary *)dictionary
{
    NSData *dataForImage = dictionary[PLANET_IMAGE];
    UIImage *spaceObjectImage = [UIImage imageWithData:dataForImage];
    JRSpaceObject *spaceObject = [[JRSpaceObject alloc] initWithData:dictionary andImage:spaceObjectImage];
    return spaceObject;
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

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        return YES;
    }else{
        return NO;
    }
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        [self.addedSpaceObejcts removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        for(JRSpaceObject *spaceObject in self.addedSpaceObejcts){
            [newSavedSpaceObjectData addObject:[self spaceObjectAsAPropertyList:spaceObject]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:ADDED_SPACE_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }else if(editingStyle == UITableViewCellEditingStyleInsert){
        
    }
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
