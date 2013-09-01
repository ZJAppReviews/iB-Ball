//
//  iBSkill.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    iBSkillDefend = 2,
    iBSkillAttack = 1,
    iBSkillOthers = 0,
} iBSkillCategory;

#define P_1 @"p_1"
#define P_2 @"p_2"
#define P_3 @"p_3"
#define P_4 @"p_4"
#define P_5 @"p_5"

@interface iBSkill : NSObject <NSCoding>

@property (nonatomic, strong) NSString *skillName;
//@property (nonatomic, strong) NSString *skillRatio;

@property (nonatomic, assign) NSInteger useNumber;
@property (nonatomic, assign) NSInteger successNumber;
@property (nonatomic) iBSkillCategory skillCategory;
@property (nonatomic, strong) NSString *skillDescription;


- (id)initWithName:(NSString *)name andTag:(iBSkillCategory)tag;
- (id)initWithName:(NSString *)name andDescrip:(NSString *)descrip andTag:(iBSkillCategory)tag;

- (float)getRatio;

@end
