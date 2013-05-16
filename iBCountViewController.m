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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateRatio:nil];

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
    if (sender.tag == 1) {
        if (self.whatTypeOfCountingAreWeIn == CountForHotZone) {
            // so we are count for hot zone
            // 1. get the hotzone as a integer
            NSInteger key = self.hotzoneTag;
            NSString *keyString = [NSString stringWithFormat:@"%d", key];
            // 2. get the array of the integer of the dict
//            id hotzoneDictId = [self.countModel.hotzoneDict objectForKey:keyString];
//            id hotzoneDictId = [self.countModel.hotzoneDict objectForKey:keyString];
            NSMutableDictionary *hotzoneDict = [iBDataCenterForHotzone hotzoneDict];
            NSArray *hotzoneArray = (NSArray *)[hotzoneDict objectForKey:keyString];
            if (hotzoneArray == nil) {
                NSNumber *n1 = [NSNumber numberWithInt:0];
                NSNumber *n2 = [NSNumber numberWithInt:0];
                NSArray *a = [NSArray arrayWithObjects:n1, n2, nil];
                hotzoneArray = a;
            }
            // 3. manage the data
            NSNumber *n1 = [hotzoneArray objectAtIndex:0];
            NSNumber *n2 = [hotzoneArray objectAtIndex:1];
            
            int newN1 = n1.integerValue + 1;
            int newN2 = n2.integerValue + 1;
            
            NSNumber *nN1 = [NSNumber numberWithInt:newN1];
            NSNumber *nN2 = [NSNumber numberWithInt:newN2];
            
            NSArray *b = [NSArray arrayWithObjects:nN1, nN2, nil];
            [[iBDataCenterForHotzone hotzoneDict] setValue:b forKey:keyString];
            NSLog([iBDataCenterForHotzone hotzoneDict].description);
            return;
        }
        //        NSLog(@"before %d", [self countModel].shootingTimes);
        //        [[self countModel] setShootingTimes:([self countModel].shootingTimes + 1)];
        NSLog(@"nange%d %d", self.countModel.goalTimes, self.countModel.shootingTimes);

        [self countModel].shootingTimes++;
        [self countModel].goalTimes++;

        //        [[self countModel] setGoalTimes:([self countModel].goalTimes + 1)];
        [self countModel].totalShootingTimes++;
        [self countModel].totalGoalTimes++;
        //        NSLog(@"after %d", [self countModel].shootingTimes);
        
        [self coreDataAddOne];

    }
    
    else if (sender.tag == 0) {
        if (self.whatTypeOfCountingAreWeIn == CountForHotZone) {
            if (self.whatTypeOfCountingAreWeIn == CountForHotZone) {
                // so we are count for hot zone
                // 1. get the hotzone as a integer
                NSInteger key = self.hotzoneTag;
                NSString *keyString = [NSString stringWithFormat:@"%d", key];
                // 2. get the array of the integer of the dict
                //            id hotzoneDictId = [self.countModel.hotzoneDict objectForKey:keyString];
                //            id hotzoneDictId = [self.countModel.hotzoneDict objectForKey:keyString];
                NSMutableDictionary *hotzoneDict = [iBDataCenterForHotzone hotzoneDict];
                NSArray *hotzoneArray = (NSArray *)[hotzoneDict objectForKey:keyString];
                if (hotzoneArray == nil) {
                    NSNumber *n1 = [NSNumber numberWithInt:0];
                    NSNumber *n2 = [NSNumber numberWithInt:0];
                    NSArray *a = [NSArray arrayWithObjects:n1, n2, nil];
                    hotzoneArray = a;
                }
                // 3. manage the data
                NSNumber *n1 = [hotzoneArray objectAtIndex:0];
                NSNumber *n2 = [hotzoneArray objectAtIndex:1];
                
                int newN1 = n1.integerValue;
                int newN2 = n2.integerValue + 1;
                
                NSNumber *nN1 = [NSNumber numberWithInt:newN1];
                NSNumber *nN2 = [NSNumber numberWithInt:newN2];
                
                NSArray *b = [NSArray arrayWithObjects:nN1, nN2, nil];
                [[iBDataCenterForHotzone hotzoneDict] setValue:b forKey:keyString];
                return;
                //            NSLog(self.countModel.hotzoneDict.description);
            }
            //        NSLog(@"before %d", [self countModel].shootingTimes);
            //        [[self countModel] setShootingTimes:([self countModel].shootingTimes + 1)];
            NSLog(@"nange%d %d", self.countModel.goalTimes, self.countModel.shootingTimes);
            
            [self countModel].shootingTimes++;
            [self countModel].goalTimes++;
            
            //        [[self countModel] setGoalTimes:([self countModel].goalTimes + 1)];
            [self countModel].totalShootingTimes++;
            [self countModel].totalGoalTimes++;
            //        NSLog(@"after %d", [self countModel].shootingTimes);
            
            [self coreDataAddOne];
            

        }
        [self countModel].shootingTimes++;
        [self countModel].totalShootingTimes++;
    }
    
    // go fuck yourself, i'm gonna use some fancy way to do this...
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self countModel].shootingTimes--;
        [self countModel].totalShootingTimes--;
    });
    
    NSString *ratio = [NSString stringWithFormat:@"%.1f", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
    
    // in the end, do the save stuff
    
}

- (void)coreDataAddOne {
//    TwoPoint *a = (TwoPoint *)[NSEntityDescription ];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];

    NSDate *today = [NSDate date];
//    NSLog(@"Date for locale %@: %@",
//          [[dateFormatter locale] localeIdentifier], [dateFormatter stringFromDate:today]);
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

- (void)coreDataMissOne {
    //TODO
}

- (IBAction)showCarrerScore:(id)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Carrer" message:[NSString stringWithFormat:@"Total goal: %d, total shoot: %d, your current ratio is : %.2f%% your overall ratio is : %.2f%%", self.countModel.totalGoalTimes, self.countModel.totalShootingTimes, self.countModel.getRatioForThisTime, self.countModel.getRatioForOverall] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (IBAction)saveData:(id)sender {
    [[self countModel] saveData];
}

- (IBAction)loadData:(id)sender {
    [[self countModel] loadData];
    [self updateRatio:nil];
}

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

@end
