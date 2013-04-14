//
//  iBGlobalRecorder.m
//  iB-Ball
//
//  Created by Snowmanzzz on 4/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBGlobalRecorder.h"

@implementation iBGlobalRecorder

static iBGlobalRecorder *sharedInstance = nil;
+ (iBGlobalRecorder *)getGlobalRecorder {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[iBGlobalRecorder alloc] init];
    });
    return sharedInstance;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.twoPointDict forKey:@"twoPointDict"];
    [aCoder encodeObject:self.threePointDict forKey:@"threePointDict"];
    [aCoder encodeObject:self.freeThrowDict forKey:@"freeThrowDict"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        self.twoPointDict = [aDecoder decodeObjectForKey:@"twoPointDict"];
        self.threePointDict = [aDecoder decodeObjectForKey:@"threePointDict"];
        self.freeThrowDict = [aDecoder decodeObjectForKey:@"freeThrowDict"];
    }
    return self;
}
@end
