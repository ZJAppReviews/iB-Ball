//
//  TwoPoint.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/5/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "TwoPoint.h"


@implementation TwoPoint

@dynamic twoPointDay;
@dynamic twoPointGoal;
@dynamic twoPointTotal;

- (NSString *)description {
    return [[super description] stringByAppendingString:[@"twoPointDay" stringByAppendingString:self.twoPointDay]];
}

@end
