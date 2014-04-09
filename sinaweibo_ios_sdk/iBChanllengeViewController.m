//
//  iBChanllengeViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-5-27.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBChanllengeViewController.h"
#import <EventKit/EventKit.h>
#import "MWKProgressIndicator.h"

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
    [MWKProgressIndicator show];
    [MWKProgressIndicator updateProgress:0.8];
}


- (void)timeUp {
    NSLog(@"shit");
    EKCalendarItem *ekc = [[EKCalendarItem alloc] init];
    [ekc addAlarm:[EKAlarm alarmWithRelativeOffset:35]];
    NSString *soundFilePath = [[NSBundle mainBundle] pathForResource:@"alarm" ofType:@"mp3"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:soundFilePath];
    AVAudioPlayer *ap = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    self.player = ap;
    [ap setDelegate:self];
    [self.player prepareToPlay];
    [self.player play];
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(musicStop) userInfo:nil repeats:NO];
}

- (void)musicStop {
    [self.player stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startTiming:(id)sender {
//    NSLog(self.timer.description);
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeUp) userInfo:nil repeats:NO];

}
@end
