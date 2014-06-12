//
//  iBObj_DataModel.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObjDataModel.h"

@implementation iBObjDataModel

- (id)initWithObj:(int)two three:(int)three ft:(int)ft {
    if (self = [super init]) {
        self.twoPoint_Obj = two;
        self.threePoint_Obj = three;
        self.ftPoint_Obj = ft;
    }
    return self;
}

- (void)areWeCoolAboutAllTheThing {
    if (self.twoPoint_Obj <= self.twoPoint_real &&
        self.threePoint_Obj <= self.threePoint_real &&
        self.ftPoint_Obj <= self.ftPoint_real) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Well Done, you are fucking awesome" message:@"See title" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
//        NSLog([self description]);
    }
}

- (NSString *)description {
//    return [@"aa" stringByAppendingString:[self description]] ;
    return [NSString stringWithFormat:@"%d %d %d", self.twoPoint_Obj, self.threePoint_Obj, self.ftPoint_Obj];
}

@end
