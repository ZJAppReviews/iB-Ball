//
//  iBDataCenter.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountModelForTwoAndThree.h"
#import <Foundation/Foundation.h>
#define kTST @"TST"
#define kTGT @"TGT"

@implementation iBCountModelForTwoAndThree
//- (void)encodeWithCoder:(NSCoder *)aCoder {
//    [aCoder encodeInt:self.totalShootingTimes forKey:kTST];
//    [aCoder encodeInt:self.totalGoalTimes forKey:kTGT];
//}

- (id)initWithShooting:(int)shoot goal:(int)goal {
    self = [super init];
    if (self) {
        // Initialize self.
        _shootingTimes = shoot;
        _goalTimes = goal;
    }
    return self;
}

- (id)init
{
    self = [super init];
    if (self) {
        self = [self initWithShooting:0 goal:0];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    int totalShootingTimes = [aDecoder decodeIntegerForKey:kTST];
    int totalGoalTimes = [aDecoder decodeIntegerForKey:kTGT];
    return [self initWithShooting:totalShootingTimes goal:totalGoalTimes];
}

- (float)getRatioForThisTime {
    return (float)_goalTimes / (float)_shootingTimes * 100;
}

- (float)getRatioForOverall {
    return (float)self.totalGoalTimes / (float)self.totalShootingTimes * 100;
}

- (NSString *)currentContentFilePath {
    NSArray *documentDirectories =
    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [documentDirectories objectAtIndex:0];
    return [documentsDirectory
            stringByAppendingPathComponent:@"shoot"];
}

- (void)saveData {
}

- (void)loadData {
    NSString *filePath = [self currentContentFilePath];
    NSArray *data = [NSArray arrayWithContentsOfFile:filePath];
    NSNumber *n1 = [data objectAtIndex:0];
    NSNumber *n2 = [data objectAtIndex:1];
    self.totalShootingTimes = n2.intValue;
    self.shootingTimes = n2.intValue;
    self.totalGoalTimes = n1.intValue;
    self.goalTimes = n1.intValue;
    NSLog(@"%@", self);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d %d  --- %d %d", self.shootingTimes, self.totalShootingTimes, self.goalTimes, self.totalGoalTimes];
}

@end
