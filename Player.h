//
//  Player.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-18.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Player : NSManagedObject

@property (nonatomic, retain) NSNumber * threePointScore;
@property (nonatomic, retain) NSNumber * threePointTry;
@property (nonatomic, retain) NSNumber * twoPointScore;
@property (nonatomic, retain) NSNumber * twoPointTry;

@end
