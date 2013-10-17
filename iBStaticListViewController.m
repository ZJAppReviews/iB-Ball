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
#import "ThreePoint.h"

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
    [self getPlayerPointCount];
    
    NSLog(@"ss");
}

- (void)getPlayerPointCount {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
    }
    if (fetchedObjects.count == 0) {
        NSLog(@"no player found");
        return;
    }
    Player *player = fetchedObjects[0];
    float ratio = [player.twoPointScore integerValue] / (CGFloat)[player.twoPointTry integerValue] * 100;
    float ratio2 = [player.threePointScore integerValue] / (CGFloat)[player.threePointTry integerValue] * 100;
    self.twoPointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.twoPointScore, player.twoPointTry, ratio];
    self.threePointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.threePointScore, player.threePointTry, ratio2];
}

- (void)viewWillAppear:(BOOL)animated {
    [self getPlayerPointCount];
    [self getTwoPointData];
    [self getThreePointData];
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
    
    if (fetchedObjects.count == 0) {
        NSLog(@"no 2-pt found");
        return;
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
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"threePointGoal" ascending:NO]];
    
    
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
    }
    
    NSLog(@"%@", fetchedObjects);
    
    if (fetchedObjects.count == 0) {
        NSLog(@"no 3-pt found");
        return;
    }
    NSString *date = ((ThreePoint *)fetchedObjects[0]).threePointDay;
    NSString *label = [date stringByAppendingString:[NSString stringWithFormat:@"  %@ ", ((ThreePoint *)fetchedObjects[0]).threePointGoal]];
    
    self.threePointCellView.detailTextLabel.text = [NSString stringWithFormat:@" %@", label];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
