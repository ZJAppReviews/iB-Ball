//
//  iBObj_DataModel.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObj_DataModel.h"

@implementation iBObj_DataModel

- (id)initWithObj:(int)two three:(int)three ft:(int)ft {
    if (self = [super init]) {
        self.twoPoint_Obj = two;
        self.threePoint_Obj = three;
        self.ftPoint_Obj = ft;
    }
    return self;
}

@end
