//
//  iBSkill.m
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBSkill.h"

@implementation iBSkill


- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        _skillName = name;
    }
    return self;
}

- (float)getRatio {
    return self.successNumber / self.useNumber;
}

@end

