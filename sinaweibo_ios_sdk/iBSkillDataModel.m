//
//  iBSkillDataSource.m
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBSkillDataModel.h"
#import "iBSkill.h"

@implementation iBSkillDataModel



- (id)init
{
    self = [super init];
    if (self) {
        iBSkill *a1 = [[iBSkill alloc] initWithName:@"Fire Tornado" andTag:iBSkillAttack];
        iBSkill *a2 = [[iBSkill alloc] initWithName:@"Ice Ground" andTag:iBSkillDefend];
        _skillArray = [NSMutableArray arrayWithObjects:a1, a2, nil];
    }
    return self;
}

- (int)getSkillCount {
    return [self.skillArray count];
}

@end
