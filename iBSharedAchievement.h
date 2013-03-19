//
//  iBSharedAchievement.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/20/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBSharedAchievement : NSObject


+ (iBSharedAchievement *)sharedAchievement;

@property (nonatomic, assign) NSInteger twoPointGoal;
@property (nonatomic, assign) NSInteger twoPointCurrent;


- (void)checkToSeeTHeAchievement;

@end
