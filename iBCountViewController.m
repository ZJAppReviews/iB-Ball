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

@interface iBCountViewController ()

@end

@implementation iBCountViewController
//- (CountModel *)countModel {
//    if (_countModel == nil) {
//        return [[CountModel alloc] init];
//    }
//    return nil;
//}

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
	// Do any additional setup after loading the view.
    NSLog(@"the type is %d", self.whatTypeOfCountingAreWeIn);
    _countModel = [[iBDataCenterForHotzone alloc] init];
    // 10 for that date, maybe not properlly
    NSString *today_22 = [[[NSDate date] description] substringToIndex:10];
    NSLog(@"oop");
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] stringForKey:today_22]);
    NSLog(@"s");
    
    
    
    //    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    //    [testObject setObject:@"bar" forKey:@"foo"];
    //    [testObject save];
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
}

- (IBAction)miss:(id)sender {
    [self updateRatio:sender];
}

- (void)updateRatio:(UIView *)sender {
    if (sender.tag == 1) {
        //        NSLog(@"before %d", [self countModel].shootingTimes);
        //        [[self countModel] setShootingTimes:([self countModel].shootingTimes + 1)];
        [self countModel].shootingTimes++;
        [self countModel].goalTimes++;
        //        [[self countModel] setGoalTimes:([self countModel].goalTimes + 1)];
        [self countModel].totalShootingTimes++;
        [self countModel].totalGoalTimes++;
        //        NSLog(@"after %d", [self countModel].shootingTimes);
    }
    
    else if (sender.tag == 0) {
        [self countModel].shootingTimes++;
        [self countModel].totalShootingTimes++;
    }
    
    NSString *ratio = [NSString stringWithFormat:@"%.1f", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
    
    // in the end, do the save stuff
    
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
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Sina Weibo", nil];
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
        NSString *stringForGoodRatio = @"       T-Mac对你微微一笑，表示你将会是下一个他";
        postStatusText = [postStatusText stringByAppendingString:stringForGoodRatio];
        
    }
    
    NSString *appName = @" ---From iB-Ball";
    postStatusText = [postStatusText stringByAppendingString:appName];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        
        // post status
        NSLog(@"%@", postStatusText);
        SinaWeibo *sinaweibo = [self sinaweibo];
        [sinaweibo requestWithURL:@"statuses/update.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                       httpMethod:@"POST"
                         delegate:self];
        //TODO roughly set a nil
    }
}

- (SinaWeibo *)sinaweibo
{
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (IBAction)startGesture:(id)sender {
    iBGestureRecognizeViewController *a = [[iBGestureRecognizeViewController alloc] initWithNibName:@"iBGestureRecognizeViewController" bundle:nil];
    a.whatKindOfGestureReconizingAreWeIn = GestureForTwoCount;
    a.dataModelForTwo = self.countModel;
    [self presentModalViewController:a animated:YES];
}


@end
