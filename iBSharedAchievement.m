//
//  iBSharedAchievement.m
//  iB-Ball
//
//  Created by Snowmanzzz on 3/20/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBSharedAchievement.h"
#import "Toast+UIView.h"

@implementation iBSharedAchievement

static iBSharedAchievement *sharedAchievement = nil;

+ (iBSharedAchievement *)sharedAchievement {
    if (sharedAchievement == nil) {
        sharedAchievement = [[iBSharedAchievement alloc] init];
    }
    return sharedAchievement;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.twoPointGoal = 10;
    }
    return self;
}

- (void)checkToSeeTheAchievement:(UIView *)view {
    if (self.twoPointGoal <= self.twoPointCurrent) {
//        NSLog(@"Achievement!");
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"woqu" message:@"shit" delegate:nil cancelButtonTitle:@"so" otherButtonTitles:nil];
//        [alert show];
        [view makeToast:@"You got an achievement: middle distance shooter"];

    }
}
@end
