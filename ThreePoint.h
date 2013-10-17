//
//  ThreePoint.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-10-16.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ThreePoint : NSManagedObject

@property (nonatomic, retain) NSString * threePointDay;
@property (nonatomic, retain) NSNumber * threePointGoal;
@property (nonatomic, retain) NSNumber * threePointTotal;

@end
