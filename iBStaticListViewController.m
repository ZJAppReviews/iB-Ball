//
//  iBStaticListViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-3.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBStaticListViewController.h"
#import "iBAppDelegate.h"
#import "Player.h"
#import "TwoPoint.h"

@interface iBStaticListViewController ()

@end

@implementation iBStaticListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = delegate.managedObjectContext;
    [self getPlayerData];
    [self getTwoPointData];
    
    NSLog(@"ss");
}

- (void)getPlayerData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
    }
    Player *player = fetchedObjects[0];
    float ratio = [player.twoPointScore integerValue] / (CGFloat)[player.twoPointTry integerValue] * 100;
    float ratio2 = [player.threePointScore integerValue] / (CGFloat)[player.threePointTry integerValue] * 100;
    self.twoPointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.twoPointScore, player.twoPointTry, ratio];
    self.threePointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.threePointScore, player.threePointTry, ratio2];
}

- (void)getTwoPointData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"twoPointGoal" ascending:NO]];
    
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
    }
    
    NSLog(@"from two point data");
    NSLog(@"%@", fetchedObjects);
    
    NSString *date = ((TwoPoint *)fetchedObjects[0]).twoPointDay;
    NSString *label = [date stringByAppendingString:[NSString stringWithFormat:@"  %@ ", ((TwoPoint *)fetchedObjects[0]).twoPointGoal]];
    
    self.twoPointDayCell.detailTextLabel.text = [NSString stringWithFormat:@" %@", label];
}

- (void)getThreePointData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"ThreePoint"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    fetchRequest.fetchLimit = 1;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"ThreePointGoal" ascending:NO]];
    
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
    }
    
    NSLog(@"%@", fetchedObjects);
    
    NSString *date = ((TwoPoint *)fetchedObjects[0]).twoPointDay;
    NSString *label = [date stringByAppendingString:[NSString stringWithFormat:@"  %@ ", ((TwoPoint *)fetchedObjects[0]).twoPointGoal]];
    
    self.twoPointDayCell.detailTextLabel.text = [NSString stringWithFormat:@" %@", label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
