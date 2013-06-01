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

@property (nonatomic, assign) NSInteger totalShootingTimes;
@property (nonatomic, assign) NSInteger totalGoalTimes;

//@property (nonatomic, strong) NSMutableDictionary *hotzoneDict;
+ (NSMutableDictionary *)hotzoneDict;

@property (copy) NSString *docPath;


- (float)getRatioForThisTime;
- (float)getRatioForOverall;
// do the data persistense stuff
- (void)saveData;
- (void)loadData;

+ (void)setHotzoneDict:(NSDictionary *)a;
@end

