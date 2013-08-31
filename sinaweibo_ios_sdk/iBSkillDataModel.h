//
//  iBSkillDataSource.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iBSkill.h"

@interface iBSkillDataModel : NSObject


- (id)init;

- (int)getSkillCount;

- (void)addSkill:(iBSkill *)skill;

@property (nonatomic, strong) NSMutableArray *skillArray;

@property (nonatomic, strong) NSMutableArray *attackSkills;
@property (nonatomic, strong) NSMutableArray *defendingSkills;
@property (nonatomic, strong) NSMutableArray *otherSkills;

@end
