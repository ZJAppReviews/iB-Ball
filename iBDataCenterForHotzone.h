//
//  iBDataCenter.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBDataCenterForHotzone : NSObject <NSCoding> {
    NSString *_dataPath;
}

@property (nonatomic, assign) NSInteger shootingTimes;
@property (nonatomic, assign) NSInteger goalTimes;

@property (nonatomic, assign) int totalShootingTimes;
@property (nonatomic, assign) int totalGoalTimes;
@property (copy) NSString *docPath;


- (float)getRatioForThisTime;

// do the data persistense stuff
- (void)saveData;
- (void)loadData;

@end
