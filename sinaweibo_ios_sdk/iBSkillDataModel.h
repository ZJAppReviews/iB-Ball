//
//  iBSkillDataSource.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iBSkill.h"

#define KEY_0 @"skillArray"
#define KEY_1 @"attackSkills"
#define KEY_2 @"defendingSkills"
#define KEY_3 @"otherSkills"

@interface iBSkillDataModel : NSObject <NSCoding>


- (id)init;

- (int)getSkillCount;

- (void)addSkill:(iBSkill *)skill;

@property (nonatomic, strong) NSMutableArray *skillArray;

@property (nonatomic, strong) NSMutableArray *attackSkills;
@property (nonatomic, strong) NSMutableArray *defendingSkills;
@property (nonatomic, strong) NSMutableArray *otherSkills;

@end
