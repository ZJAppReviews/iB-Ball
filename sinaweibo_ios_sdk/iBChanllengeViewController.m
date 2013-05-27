//
//  iBChanllengeViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-5-27.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBChanllengeViewController.h"

@interface iBChanllengeViewController ()

@end

@implementation iBChanllengeViewController

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
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(timeUp) userInfo:nil repeats:NO];
}

- (void)timeUp {
    NSLog(@"shit");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTiming:(id)sender {
    NSLog(self.timer.description);
}
@end
