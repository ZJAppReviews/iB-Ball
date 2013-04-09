//
//  iBDataCenter.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBDataCenterForHotzone.h"
#define kTST @"TST"
#define kTGT @"TGT"

@implementation iBDataCenterForHotzone

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
    //todo
    // 1.get path
//    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [documentDirectories objectAtIndex:0];
//    NSString *path = [documentsDirectory
//            stringByAppendingPathComponent:@"shoot"];
    NSString *path = [self currentContentFilePath];
    // 2.save the two digit to the path
    // 2.1 make the two digit an nsarray
    NSNumber *n1 = [[NSNumber alloc] initWithInt:self.totalGoalTimes];
    NSNumber *n2 = [[NSNumber alloc] initWithInt:self.totalShootingTimes];
    NSArray *data = [[NSArray alloc] initWithObjects:n1, n2, nil];
    // 2.2 save it
    [data writeToFile:path atomically:YES];
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
