//
//  iBDataCenter.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>



// notice: even i gave it a name of "forHotZone", it's totally shit... still don't work
@interface iBDataCenterForHotzone : NSObject {
    NSString *_dataPath;
}

@property (nonatomic, assign) NSInteger shootingTimes;
@property (nonatomic, assign) NSInteger goalTimes;

@property (nonatomic, assign) int totalShootingTimes;
@property (nonatomic, assign) int totalGoalTimes;
@property (copy) NSString *docPath;


- (float)getRatioForThisTime;
- (float)getRatioForOverall;

// do the data persistense stuff
- (void)saveData;
- (void)loadData;

@end
