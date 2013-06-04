//
//  iBChanllengeViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-5-27.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface iBChanllengeViewController : UIViewController <AVAudioPlayerDelegate>

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) AVAudioPlayer *player;

- (IBAction)startTiming:(id)sender;

@end
