//
//  iBSkill.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBSkill : NSObject

@property (nonatomic, strong) NSString *skillName;
//@property (nonatomic, strong) NSString *skillRatio;

@property (nonatomic, assign) NSInteger useNumber;
@property (nonatomic, assign) NSInteger successNumber;

- (id)initWithName:(NSString *)name;

- (float)getRatio;

@end
