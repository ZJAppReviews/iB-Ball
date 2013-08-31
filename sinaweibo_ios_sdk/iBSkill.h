//
//  iBSkill.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    iBSkillDefend = 1,
    iBSkillAttack = 2,
    iBSkillOthers = 0,
} iBSkillCategory;

@interface iBSkill : NSObject

@property (nonatomic, strong) NSString *skillName;
//@property (nonatomic, strong) NSString *skillRatio;

@property (nonatomic, assign) NSInteger useNumber;
@property (nonatomic, assign) NSInteger successNumber;
@property (nonatomic, strong) NSString *skillDescription;
@property (nonatomic) iBSkillCategory skillCategory;

- (id)initWithName:(NSString *)name andTag:(iBSkillCategory)tag;
- (id)initWithName:(NSString *)name andDescrip:(NSString *)descrip andTag:(iBSkillCategory)tag;

- (float)getRatio;

@end
