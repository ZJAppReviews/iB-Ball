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
    _countModel = [[iBDataCenterForHotzone alloc] init];
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
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Carrer" message:[NSString stringWithFormat:@"Total goal: %d, total shoot: %d", self.countModel.totalGoalTimes, self.countModel.totalShootingTimes] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [av show];
}

- (IBAction)saveData:(id)sender {
    [[self countModel] saveData];
}

- (IBAction)loadData:(id)sender {
    [[self countModel] loadData];
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
        postStatusText = [[NSString alloc] initWithFormat:@"今日三分球怒中%d, 怒打%d次铁, 命中率为%2.1f '%' ---From iB-Ball develped by Nango", goal, shoot - goal, ((double)(goal) / shoot) * 100];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Will post status with text \"%@\"", postStatusText]
                                                           delegate:self cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        // post status
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

@end
