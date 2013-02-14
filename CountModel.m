//
//  CountModell.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "CountModel.h"

@implementation CountModel

- (id)init {
    if (self == ([super init])) {
        NSLog(@"initialize!");
//        _shootingTimes = 0;
//        _goalTimes = 0;
    }
    return self;
}

- (float)getRatio {
    return (float)_goalTimes / (float)_shootingTimes * 100;
}

@end
