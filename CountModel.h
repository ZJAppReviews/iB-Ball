//
//  CountModell.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountModel : NSObject {
//    int _shootingTimes;
//    int _goalTimes;
}
@property (nonatomic, assign) NSInteger shootingTimes;
@property (nonatomic, assign) NSInteger goalTimes;

- (float)getRatio;


@end
