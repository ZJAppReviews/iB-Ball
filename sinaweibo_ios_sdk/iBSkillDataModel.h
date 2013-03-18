//
//  iBSkillDataSource.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBSkillDataModel : NSObject

@property (nonatomic, strong) NSMutableArray *skillArray;

- (int)getSkillCount;

@end
