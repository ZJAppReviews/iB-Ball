//
//  ibCountViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountViewController.h"
#import "iBDataCenterForHotzone.h"
#import "iBShareViewController.h"
#import "iBAppDelegate.h"
#import "iBGestureRecognizeViewController.h"
#import <Parse/Parse.h>
#import "TwoPoint.h"
#import "Player.h"


@interface iBCountViewController ()

@end

@implementation iBCountViewController

#define RENREN_TAG 1
#define WEIBO_TAG 2

- (iBDataCenterForHotzone *)countModel {
    if (_countModel == nil) {
        _countModel = [[iBDataCenterForHotzone alloc] init];
    }
    return _countModel;
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [self updateRatio:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self updateRatio:nil];

	// Do any additional setup after loading the view.
    

//    _countModel = [[iBDataCenterForHotzone alloc] init];
    // 10 for that date, maybe not properlly
//    NSString *today_22 = [[[NSDate date] description] substringToIndex:10];
//    NSLog(@"oop");
//    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] stringForKey:today_22]);

    
    
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    [testObject setObject:@"bar" forKey:@"foo"];
    //    [testObject save];
    
    
    // manage the core data
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = delegate.managedObjectContext;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setShootingRatio:nil];
}

- (IBAction)score:(id)sender {
    [self updateRatio:sender];
    NSLog(@"%d", self.countModel.shootingTimes);

}

- (IBAction)miss:(id)sender {
    [self updateRatio:sender];
    NSLog(@"%d", self.countModel.shootingTimes);

}

- (void)updateRatio:(UIView *)sender {
    if (sender == nil) {
        return;
    }
    if (sender.tag == 1) {
        [self coreDataAddOne];
    }
    
    else if (sender.tag == 0) {
        if (self.whatTypeOfCountingAreWeIn == CountForHotZone) {
            //TODO why add this crap??
            [self coreDataAddOne];
            

        }
        [self countModel].shootingTimes++;
        [self countModel].totalShootingTimes++;
        [self coreDataMissOne];
    }
    
    // go fuck yourself, i'm gonna use some fancy way to do this...
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self countModel].shootingTimes--;
        [self countModel].totalShootingTimes--;
    });
    
    NSString *ratio = [NSString stringWithFormat:@"%.1f", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
    
}

- (void)coreDataAddOne {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    NSDate *today = [NSDate date];

    
    // deal the situation where the TwoPoint Already Exist
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
        NSLog(@"wori");
    }
    
    if (fetchedObjects.count > 0) {
    
        // get the day
        NSString *dayWeAreIn = [dateFormatter stringFromDate:today];
        // fileter the day & crap***
        for (TwoPoint *tp in fetchedObjects) {
            if ([tp.twoPointDay isEqualToString:dayWeAreIn]) {
                int theOriginal = [tp.twoPointGoal intValue];
                int theOriginal2 = [tp.twoPointTotal intValue];
                NSNumber *a1 = [NSNumber numberWithInt:++theOriginal];
                NSNumber *a2 = [NSNumber numberWithInt:++theOriginal2];
                
                tp.twoPointGoal = a1;
                tp.twoPointTotal = a2;
                
                NSError *err;
                [self.managedObjectContext save:&err];
            }
        }
    } else {
        TwoPoint *a = (TwoPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"TwoPoint" inManagedObjectContext:_managedObjectContext];
        
        a.twoPointDay = [dateFormatter stringFromDate:today];
        int theOriginal = [a.twoPointGoal intValue];
        int theOriginal2 = [a.twoPointTotal intValue];
        NSNumber *a1 = [NSNumber numberWithInt:++theOriginal];
        NSNumber *a2 = [NSNumber numberWithInt:++theOriginal2];
        
        a.twoPointGoal = a1;
        a.twoPointTotal = a2;
        
        NSError *err;
        [self.managedObjectContext save:&err];
    }
    
    
    // 2.get the People model right, add stuff to it
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Player"
                                              inManagedObjectContext:context];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];

    [fetchRequest2 setEntity:entity2];
    
    NSError *error2;
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error2];
    if (fetchedObjects2 == nil) {
        // Handle the error.
        NSLog(@"wori");
    }
    Player *player;
    NSLog(@"%d", fetchedObjects2.count);

    if (fetchedObjects2.count == 0) {
        player = (Player *)[NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:_managedObjectContext];
                
        NSError *err;
        [self.managedObjectContext save:&err];

    } else if (fetchedObjects2.count > 1) {
        NSLog(@"fetched player more than 1");
    } else {
        player = fetchedObjects2[0];
    }

    
    
    if (self.whatTypeOfCountingAreWeIn == CountForTwo) {
        int i = [player.twoPointScore integerValue];
        i++;
        int j = [player.twoPointTry integerValue];
        j++;
        player.twoPointScore = [NSNumber numberWithInt:i];
        player.twoPointTry = [NSNumber numberWithInt:j];
        [self.managedObjectContext save:&error2];
    }
}

- (void)coreDataMissOne {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    
    NSDate *today = [NSDate date];
    
    
    // deal the situation where the TwoPoint Already Exist
    NSManagedObjectContext *context = self.managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error.
        NSLog(@"wori");
    }
    
    if (fetchedObjects.count > 0) {
        
        // get the day
        NSString *dayWeAreIn = [dateFormatter stringFromDate:today];
        // fileter the day & crap***
        for (TwoPoint *tp in fetchedObjects) {
            if ([tp.twoPointDay isEqualToString:dayWeAreIn]) {
                int theOriginal = [tp.twoPointGoal intValue];
                int theOriginal2 = [tp.twoPointTotal intValue];
                NSNumber *a1 = [NSNumber numberWithInt:theOriginal];
                NSNumber *a2 = [NSNumber numberWithInt:++theOriginal2];
                
                tp.twoPointGoal = a1;
                tp.twoPointTotal = a2;
                
                NSError *err;
                [self.managedObjectContext save:&err];
            }
        }
    } else {
        TwoPoint *a = (TwoPoint *)[NSEntityDescription insertNewObjectForEntityForName:@"TwoPoint" inManagedObjectContext:_managedObjectContext];
        
        a.twoPointDay = [dateFormatter stringFromDate:today];
        int theOriginal = [a.twoPointGoal intValue];
        int theOriginal2 = [a.twoPointTotal intValue];
        NSNumber *a1 = [NSNumber numberWithInt:theOriginal];
        NSNumber *a2 = [NSNumber numberWithInt:++theOriginal2];
        
        a.twoPointGoal = a1;
        a.twoPointTotal = a2;
        
        NSError *err;
        [self.managedObjectContext save:&err];
    }
    
    
    // 2.get the People model right, add stuff to it
    NSEntityDescription *entity2 = [NSEntityDescription entityForName:@"Player"
                                               inManagedObjectContext:context];
    NSFetchRequest *fetchRequest2 = [[NSFetchRequest alloc] init];
    
    [fetchRequest2 setEntity:entity2];
    
    NSError *error2;
    NSArray *fetchedObjects2 = [context executeFetchRequest:fetchRequest2 error:&error2];
    if (fetchedObjects2 == nil) {
        // Handle the error.
        NSLog(@"wori");
    }
    Player *player;
    NSLog(@"%d", fetchedObjects2.count);
    
    if (fetchedObjects2.count == 0) {
        player = (Player *)[NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:_managedObjectContext];
        
        NSError *err;
        [self.managedObjectContext save:&err];
        
    } else if (fetchedObjects2.count > 1) {
        NSLog(@"fetched player more than 1");
    } else {
        player = fetchedObjects2[0];
    }
    
    
    
    if (self.whatTypeOfCountingAreWeIn == CountForTwo) {
        int i = [player.twoPointScore integerValue];
        int j = [player.twoPointTry integerValue];
        j++;
        player.twoPointScore = [NSNumber numberWithInt:i];
        player.twoPointTry = [NSNumber numberWithInt:j];
        [self.managedObjectContext save:&error2];
    }
}

- (IBAction)showCarrerScore:(id)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Carrer" message:[NSString stringWithFormat:@"Total goal: %d, total shoot: %d, your current ratio is : %.2f%% your overall ratio is : %.2f%%", self.countModel.totalGoalTimes, self.countModel.totalShootingTimes, self.countModel.getRatioForThisTime, self.countModel.getRatioForOverall] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

#pragma mark - file save -
- (IBAction)saveData:(id)sender {
    [[self countModel] saveData];
}

int choice = 0;
- (IBAction)loadData:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Do you really wanna the data?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    as.tag = 10;
    [as showInView:self.view];
}



#pragma mark

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)share:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Sina Weibo", @"Renren", nil];
    [as showFromBarButtonItem:sender animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"share"]) {
        iBShareViewController *a = [segue destinationViewController];
        [a setShoot:self.countModel.shootingTimes];
        [a setGoal:self.countModel.goalTimes];
    }
}


NSString *postStatusText;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 10) {
        if (buttonIndex == 0) {
            choice = 1;
            
            if (choice) {
                [[self countModel] loadData];
                [self updateRatio:nil];
                choice = 0;
            }
            return;
        }
        if ( buttonIndex == 1) {
            NSLog(@"safw");
            return;
        }
    }
    
    if (buttonIndex == 0) {
        int shoot = self.countModel.shootingTimes;
        int goal = self.countModel.goalTimes;
        
        if (shoot == 0) {
            NSLog(@"Are you crazy?");
            return;
        }
        
        NSString *typeOfString = nil;
        switch (self.whatTypeOfCountingAreWeIn) {
            case CountForTwo:
                typeOfString = @"两分球";
                break;
            case CountForThree:
                typeOfString = @"三分球";
                break;
            case CountForNormal:
                typeOfString = @"投篮";
                break;
            default:
                break;
        }
        
        postStatusText = [[NSString alloc] initWithFormat:@"今日%@命中%d球, 怒打%d次铁, 命中率为%2.1f %%", typeOfString, goal, shoot - goal, ((double)(goal) / shoot) * 100];
        NSString *today_1 = [NSString stringWithString:postStatusText];
        NSString *today_2 = [[[NSDate date] description] substringToIndex:10];
        
        NSDictionary *dictForToday = [NSDictionary dictionaryWithObjectsAndKeys:today_1, today_2, nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults registerDefaults:dictForToday];
        
        
        [self makeSomeCoolThingsOnPostStatusText];
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Will post status with text \"%@\"", postStatusText]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        alertView.tag = WEIBO_TAG;
        [alertView show];
        
    }
    if (buttonIndex == 1) {
        int shoot = self.countModel.shootingTimes;
        int goal = self.countModel.goalTimes;
        
        if (shoot == 0) {
            NSLog(@"Are you crazy?");
            return;
        }
        
        NSString *typeOfString = nil;
        switch (self.whatTypeOfCountingAreWeIn) {
            case CountForTwo:
                typeOfString = @"两分球";
                break;
            case CountForThree:
                typeOfString = @"三分球";
                break;
            case CountForNormal:
                typeOfString = @"投篮";
                break;
            default:
                break;
        }
        
        postStatusText = [[NSString alloc] initWithFormat:@"今日%@命中%d球, 怒打%d次铁, 命中率为%2.1f %%", typeOfString, goal, shoot - goal, ((double)(goal) / shoot) * 100];
        NSString *today_1 = [NSString stringWithString:postStatusText];
        NSString *today_2 = [[[NSDate date] description] substringToIndex:10];
        
        NSDictionary *dictForToday = [NSDictionary dictionaryWithObjectsAndKeys:today_1, today_2, nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults registerDefaults:dictForToday];
        
        
        [self makeSomeCoolThingsOnPostStatusText];
        
        
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Will post status with text \"%@\"", postStatusText]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        alertView.tag = RENREN_TAG;
        [alertView show];
        
    }
}

- (void)makeSomeCoolThingsOnPostStatusText {
    if (self.countModel.getRatioForThisTime < 50) {
        // just test first
        
        NSString *stringForAll = @"      科比紧握您的双手，流下了温热的眼泪";
        postStatusText = [postStatusText stringByAppendingString:stringForAll];
    }
    if (self.countModel.getRatioForThisTime >= 50) {
        NSString *stringForGoodRatio = @"       T-Mac对你嫣然一笑，表示你将会是下一个他";
        postStatusText = [postStatusText stringByAppendingString:stringForGoodRatio];
        
    }
    
    NSString *appName = @" ---From iB-Ball";
    postStatusText = [postStatusText stringByAppendingString:appName];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == WEIBO_TAG) {
        
        // post status
        NSLog(@"%@", postStatusText);
        SinaWeibo *sinaweibo = [self sinaweibo];
        [sinaweibo requestWithURL:@"statuses/update.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                       httpMethod:@"POST"
                         delegate:self];
        //TODO roughly set a nil
    }
    if (buttonIndex == RENREN_TAG) {
        Renren *renren = [Renren sharedRenren];
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:10];
        [params setObject:@"status.set" forKey:@"method"];
        [params setObject:postStatusText forKey:@"status"];
        [renren requestWithParams:params andDelegate:self];
        

    }
}


- (IBAction)startGesture:(id)sender {
    // judge the type of counting and pass it to the gesture
    GestureType gg = nil;
    switch (self.whatTypeOfCountingAreWeIn) {
        case CountForTwo:
            gg = GestureForTwoCount;
            break;
        case CountForThree:
            gg = GestureForThreeCount;
            break;
        case CountForNormal:
            //TODO
            break;
        default:
            break;
    }
    
    
    iBGestureRecognizeViewController *a = [[iBGestureRecognizeViewController alloc] initWithNibName:@"iBGestureRecognizeViewController" bundle:nil];
    a.whatKindOfGestureReconizingAreWeIn = gg;
//    a.whatKindOfGestureReconizingAreWeIn = GestureForTwoCount;
    // get the rightmodel, maybe it's not best to separate this
    switch (gg) {
        case GestureForTwoCount:
            a.dataModelForTwo = self.countModel;
            break;
            
        case GestureForThreeCount:
            a.dataModelForThree = self.countModel;
            break;
            // TODO
        default:
            break;
    }

    [self presentModalViewController:a animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateRatio:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    if (self.whatTypeOfCountingAreWeIn != CountForHotZone) {
       
    }
    NSLog(@"Wow");
    
	NSString *path;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"zzzhotzone/"];
    // save the hotzone data
    if ([[iBDataCenterForHotzone hotzoneDict] writeToFile:path atomically:NO]) {
        NSLog(@"success");
    }
    else {
        NSLog(@"fail");
    }
    return;
}

#pragma mark - RenrenDelegate -

/**
 * 接口请求成功，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response {
    //TODO
}

/**
 * 接口请求失败，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error {
    //TODO
}


- (SinaWeibo *)sinaweibo
{
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
@end
