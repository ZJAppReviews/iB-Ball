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
    
    NSUserDefaults *nud = [NSUserDefaults standardUserDefaults];
    NSString *tagString = [NSString stringWithFormat:@"%d", self.hotzoneTag];
    NSArray *hostory = [nud objectForKey:tagString];
    NSArray *a = [self.hotzoneDict objectForKey:[NSString stringWithFormat:@"%d", self.hotzoneTag]];
    self.numberWeScoreHistory = [a[0] integerValue];
    self.numberWeTryHistory = [a[1] integerValue];

    NSInteger n1 = [a[0] integerValue];
    NSInteger n2 = [a[1] integerValue];
((UILabel *)    self.trainingResultHistory).text =
    [NSString stringWithFormat:@"%d/ %d %f%%", n1, n2, (CGFloat)n1 / n2];

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
    self.numberWeTry++;
    self.numberWeScore++;
    [self updateResult];
}

- (IBAction)miss:(id)sender {
    self.numberWeTry++;
    [self updateResult];

}

- (void)updateResult {
    float i = (float)self.numberWeScore / self.numberWeTry;
    NSString *str = [NSString stringWithFormat:@"ratio:%.2f%%", i * 100];
    self.trainingResult.text = str;
    
    NSString *tagString = [NSString stringWithFormat:@"%d", self.hotzoneTag];
    // get hozone static
    NSArray *a = [[NSUserDefaults standardUserDefaults] objectForKey:tagString];
    CGFloat ratio = (CGFloat)[a[0] integerValue] / [a[1] integerValue];
    self.trainingResultHistory.text = [NSString stringWithFormat:@"%d %d ratioi:%.2f%%", [a[0] integerValue], [a[1] integerValue], ratio];
    NSLog(@"%d, %d", [a[0] integerValue], [a[1] integerValue]);
    
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateResult];
}
- (void)coreDataScoreOne {
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
- (BOOL)isTwoPoint {
    //TODO
    return YES;
}

- (IBAction)gotoGestureMode:(id)sender {
    iBCountViewControllerForHotZoneGestureMode *ibcc = [[iBCountViewControllerForHotZoneGestureMode alloc] initWithNibName:@"iBCountViewControllerForHotZoneGestureMode" bundle:nil];
    ibcc.numberWeScore = self.numberWeScore;
    ibcc.numberWeTry = self.numberWeTry;
    [self.navigationController pushViewController:ibcc animated:YES];
    ibcc.delegate = self;
}

- (void)gestureInfoChange:(NSInteger)number1 and:(NSInteger)number2 {
    self.numberWeScore = number1;
    self.numberWeTry = number2;
}

- (void)saveStaticsToCoreData {
}

- (IBAction)toolBarSave:(id)sender {
    
//    // get the original value
//    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
//    NSDictionary *hotzoneDict = [ud objectForKey:@"hotzone"];
//    NSMutableArray *arrayInHotzoneTag = [hotzoneDict valueForKey:[NSString stringWithFormat:@"%d", self.hotzoneTag]];
//    if (arrayInHotzoneTag) {
//        NSNumber *oldValue1 = arrayInHotzoneTag[0];
//        NSNumber *oldValue2 = arrayInHotzoneTag[1];
//        NSNumber *value1 = [NSNumber numberWithInt:self.numberWeScore];
//        NSNumber *value2 = [NSNumber numberWithInt:self.numberWeTry];
//        int a = [oldValue1 integerValue] + [value1 integerValue];
//        int b = [oldValue2 integerValue] + [value2 integerValue];
//        NSNumber *aa = [NSNumber numberWithInt:a];
//        NSNumber *bb = [NSNumber numberWithInt:b];
//        NSArray *aabb = [NSArray arrayWithObjects:aa, bb, nil];
//        NSDictionary *dictHotZone = @{[NSString stringWithFormat:@"%d", self.hotzoneTag] : aabb};
//        hotzoneDict ad
//        [ud setObject:dictHotZone forKey:[NSString stringWithFormat:@"%d", self.hotzoneTag]];
//        return;
//    }
//    
//    // get the new value
//    NSNumber *position = [hotzoneDict valueForKey:[NSString stringWithFormat:@"%d", self.hotzoneTag]];
//    NSNumber *value1 = [NSNumber numberWithInt:self.numberWeScore];
//    NSNumber *value2 = [NSNumber numberWithInt:self.numberWeTry];
//    NSArray *valueArr = [NSArray arrayWithObjects:value1, value2, nil];
//    NSDictionary *dict = @{position : valueArr};
//    [ud setObject:dict forKey:@""]
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *tagString = [NSString stringWithFormat:@"%d", self.hotzoneTag];
    int i = self.numberWeScore;
    int j = self.numberWeTry;
    if ([ud objectForKey:tagString]) {
        NSArray *array = [ud objectForKey:tagString];
        i += [array[0] integerValue];
        j += [array[1] integerValue];
    }

    NSNumber *ii = [NSNumber numberWithInt:i];
    NSNumber *jj = [NSNumber numberWithInt:j];
    NSArray *ppp = [NSArray arrayWithObjects:ii, jj, nil];
    [ud setObject:ppp forKey:tagString];
    [ud synchronize];
}


@end
