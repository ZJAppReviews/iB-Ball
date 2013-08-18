//
//  iBCountViewControllerForHotZone.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBCountViewControllerForHotZone.h"
#import "iBAppDelegate.h"
#import "Player.h"
#import "iBCountViewControllerForHotZoneGestureMode.h"

@interface iBCountViewControllerForHotZone ()

@end

@implementation iBCountViewControllerForHotZone

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
    // Set the object context
    iBAppDelegate *ibad = (iBAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = ibad.managedObjectContext;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setTrainingResult:nil];
    [self setTrainingResultHistory:nil];
    [super viewDidUnload];
}

- (IBAction)score:(id)sender {
//    Player *player = (Player *)[NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:_managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    NSError *error = nil;
	NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"ss");
    }
    if (mutableFetchResults.count == 0) {
        NSLog(@"create one");
        Player *newPlayer = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:_managedObjectContext];
        if ([self isTwoPoint]) {
            newPlayer.twoPointTry = [NSNumber numberWithInt:1];
            newPlayer.twoPointScore = [NSNumber numberWithInt:1];
        }
        else {
            newPlayer.threePointTry = [NSNumber numberWithInt:1];
            newPlayer.threePointScore = [NSNumber numberWithInt:1];
        }
        
    }
    else if (mutableFetchResults.count > 1) {
        NSLog(@"ss player more than one");
    }
    else if (mutableFetchResults.count == 1) {
        if ([self isTwoPoint]) {
            Player *player = ((Player *)mutableFetchResults[0]);
            int i = [player.twoPointScore integerValue];
            int j = [player.twoPointTry integerValue];
            player.twoPointScore = [NSNumber numberWithInt:(i + 1)];
            player.twoPointTry = [NSNumber numberWithInt:(j + 1)];
            
        } else {
            Player *player = ((Player *)mutableFetchResults[0]);
            int i = [player.threePointScore integerValue];
            player.threePointScore = [NSNumber numberWithInt:(i + 1)];
            int j = player.threePointTry;
            player.threePointTry = [NSNumber numberWithInt:(j + 1)];

        }
    }
    // Commit the change.
	if (![_managedObjectContext save:&error]) {
		// Handle the error.
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);  // Fail
	}
    
    NSFetchRequest *request2 = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
    [request2 setEntity:entity2];
    NSArray *a = [self.managedObjectContext executeFetchRequest:request2 error:nil];
    NSLog(@"%d", [((Player *)a[0]).twoPointTry integerValue]);
}
- (IBAction)miss:(id)sender {
    self.numberWeTry++;
}


- (BOOL)isTwoPoint {
    //TODO
    return YES;
}

- (IBAction)gotoGestureMode:(id)sender {
    iBCountViewControllerForHotZoneGestureMode *ibcc = [[iBCountViewControllerForHotZoneGestureMode alloc] initWithNibName:@"iBCountViewControllerForHotZoneGestureMode" bundle:nil];
    [self.navigationController pushViewController:ibcc animated:YES];
    ibcc.delegate = self;
}

- (void)gestureInfoChange:(NSInteger)number1 and:(NSInteger)number2 {
    self.numberWeScore = number1;
    self.numberWeTry = number2;
}

- (void)saveStaticsToCoreData {
}

@end
