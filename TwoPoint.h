//
//  TwoPoint.h
//  iB-Ball
//
//  Created by Snowmanzzz on 5/3/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TwoPoint : NSManagedObject

@property (nonatomic, retain) NSDate * twoPointDay;
@property (nonatomic, retain) NSNumber * twoPointGoal;
@property (nonatomic, retain) NSNumber * twoPointTotal;

@end
