//
//  iBChartsViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-11-10.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBChartsViewController.h"
#import "iBAppDelegate.h"

@interface iBChartsViewController ()

@end

@implementation iBChartsViewController

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
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"twoPointDay"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    NSArray *dateArray = [fetchedObjects valueForKey:@"twoPointDay"];
    NSArray *twoPointGoal = [fetchedObjects valueForKey:@"twoPointGoal"];
    NSArray *twoPointTotal = [fetchedObjects valueForKey:@"twoPointTotal"];
    NSMutableArray *ratioArray = [NSMutableArray new];
    for (int i = 0; i < twoPointGoal.count; i++) {
        NSInteger a = [twoPointGoal[i] integerValue];
        NSInteger b = [twoPointTotal[i] integerValue];
        CGFloat c = (CGFloat)a / b;
        [ratioArray addObject:[NSNumber numberWithFloat:c]];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
