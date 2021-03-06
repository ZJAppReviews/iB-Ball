//
//  ibCountViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountViewController.h"
#import "iBCountModelForTwoAndThree.h"
#import "iBShareViewController.h"
#import "iBAppDelegate.h"
#import "iBGestureRecognizeViewController.h"
//#import <Parse/Parse.h>
#import "TwoPoint.h"
#import "Player.h"


@interface iBCountViewController () <UIActionSheetDelegate, UIAlertViewDelegate, SinaWeiboRequestDelegate, RenrenDelegate> {
    BOOL saved;
}

@end

@implementation iBCountViewController

#define RENREN_TAG 1
#define WEIBO_TAG 2
#define SAVE_ALERT_TAG 3

- (iBCountModelForTwoAndThree *)countModel {
    if (_countModel == nil) {
        _countModel = [[iBCountModelForTwoAndThree alloc] init];
        _countModel.whatTypeOfCountingAreWeIn = self.whatTypeOfCountingAreWeIn;
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
    
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind target:self action:@selector(onBackClicked)];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back-50.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onBackClicked)];
    
    
    self.navigationItem.leftBarButtonItem = backButton;

    
    iBAppDelegate *ibad = (iBAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext = ibad.managedObjectContext;

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
    saved = NO;
    [self updateRatio:sender];
    NSLog(@"%d", self.countModel.shootingTimes);
}

- (IBAction)scoreCancel:(id)sender {
    saved = NO;
    [self countModel].shootingTimes -= 1;
    [self countModel].goalTimes -= 1;
    [self countModel].totalGoalTimes -= 1;
    [self countModel].totalShootingTimes -= 1;
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
}

- (IBAction)miss:(id)sender {
    saved = NO;
    [self updateRatio:sender];
    NSLog(@"%d", self.countModel.shootingTimes);

}

- (IBAction)missCancel:(id)sender {
    saved = NO;
    [self countModel].shootingTimes -= 1;
    [self countModel].totalShootingTimes -= 1;
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
}


- (IBAction)scoreFive:(id)sender {
    saved = NO;
    [self countModel].shootingTimes += 5;
    [self countModel].goalTimes += 5;
    [self countModel].totalGoalTimes += 5;
    [self countModel].totalShootingTimes += 5;
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];

}

- (IBAction)missFive:(id)sender {
    saved = NO;
    [self countModel].shootingTimes += 5;
    [self countModel].totalShootingTimes += 5;
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];

}


- (void)updateRatio:(UIView *)sender {
    if (sender.tag == 1) {
        [self countModel].shootingTimes++;
        [self countModel].goalTimes++;
        [self countModel].totalGoalTimes++;
        [self countModel].totalShootingTimes++;

    }
    
    else if (sender.tag == 0) {
        [self countModel].shootingTimes++;
        [self countModel].totalShootingTimes++;
    }
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
}

- (void)updateRatio {
    NSString *ratio = [NSString stringWithFormat:@"%.1f%%", [[self countModel] getRatioForThisTime]];
    [self.shootingRatio setText:ratio];
}

- (IBAction)showCarrerScore:(id)sender {
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Carrer" message:[NSString stringWithFormat:@"Total goal: %d, total shoot: %d, your current ratio is : %.2f%% your overall ratio is : %.2f%%", self.countModel.totalGoalTimes, self.countModel.totalShootingTimes, self.countModel.getRatioForThisTime, self.countModel.getRatioForOverall] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

#pragma mark - file save -
- (IBAction)saveData:(id)sender {
    if (saved == YES) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"重复保存" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return;
    }
    saved = YES;
    [[self countModel] saveData];
}

int choice = 0;
- (IBAction)loadData:(id)sender {
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Do you really wanna the data?" delegate:self cancelButtonTitle:@"No" destructiveButtonTitle:@"Yes" otherButtonTitles:nil];
    as.tag = 10;
    [as showInView:self.view];
}



#pragma mark

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
        // if weibo
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
        // if renren
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
    
    NSString *appName = @" __From iB-Ball";
    postStatusText = [postStatusText stringByAppendingString:appName];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == SAVE_ALERT_TAG) {
        if (buttonIndex == 0) {
            [self saveData:nil];
        }
        saved = YES;
        return;
    }
    if (alertView.tag == WEIBO_TAG) {
    
        // post status
        NSLog(@"%@", postStatusText);
        SinaWeibo *sinaweibo = [self sinaweibo];
        [sinaweibo requestWithURL:@"statuses/update.json"
                           params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                       httpMethod:@"POST"
                         delegate:self];
        return;
    }
    if (alertView.tag == RENREN_TAG) {
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
    [self presentViewController:a animated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateRatio];
}

- (void)viewWillDisappear:(BOOL)animated {
}

- (void)onBackClicked {
    if (!saved) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否保存" message:@"您的数据尚未保存" delegate:self cancelButtonTitle:@"保存" otherButtonTitles:@"丢弃", nil];
        alert.tag = SAVE_ALERT_TAG;
        [alert show];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - RenrenDelegate -

/**
 * 接口请求成功，第三方开发者实现这个方法l
 */
- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response {
    NSLog(@"ss");
    //TODO
}

/**
 * 接口请求失败，第三方开发者实现这个方法
 */
- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error {
    NSLog(@"sss");

    //TODO
}


- (SinaWeibo *)sinaweibo
{
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}
@end
