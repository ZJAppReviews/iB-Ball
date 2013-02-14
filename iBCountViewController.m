//
//  ibCountViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountViewController.h"
#import "CountModel.h"

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
    _countModel = [[CountModel alloc] init];
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
        NSLog(@"before %d", [self countModel].shootingTimes);
        [[self countModel] setShootingTimes:([self countModel].shootingTimes + 1)];
        [[self countModel] setGoalTimes:([self countModel].goalTimes + 1)];
        NSLog(@"after %d", [self countModel].shootingTimes);
    }
    
    else if (sender.tag == 0) {
        [self countModel].shootingTimes++;
    }
    
    NSString *ratio = [NSString stringWithFormat:@"%.1f", [[self countModel] getRatio]];
    [self.shootingRatio setText:ratio];
}

@end
