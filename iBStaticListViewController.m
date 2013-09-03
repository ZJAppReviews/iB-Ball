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
    [self getData];
    
    NSLog(@"ss");
}

- (void)getData {
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
    float ratio = [player.twoPointScore integerValue] / (CGFloat)[player.twoPointTry integerValue];
    float ratio2 = [player.threePointScore integerValue] / (CGFloat)[player.threePointTry integerValue];
    self.twoPointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.twoPointScore, player.twoPointTry, ratio];
    self.threePointCellView.detailTextLabel.text = [NSString stringWithFormat:@"%@/%@ %.2f%%", player.threePointScore, player.threePointTry, ratio2];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
