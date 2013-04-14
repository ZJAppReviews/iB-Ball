//
//  iBGlobalRecorder.h
//  iB-Ball
//
//  Created by Snowmanzzz on 4/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBGlobalRecorder : NSObject <NSCoding>

@property (nonatomic, strong) NSDictionary *twoPointDict;
// dictionary will have "date: numberOfTwoPointThatYouShootIn"

@property (nonatomic, strong) NSDictionary *threePointDict;

@property (nonatomic, strong) NSDictionary *freeThrowDict;


@end
