//
//  iBObj_DataModel.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBObj_DataModel : NSObject

@property (assign) int twoPoint_Obj;
@property (assign) int threePoint_Obj;
@property (assign) int ftPoint_Obj;

@property (assign) int twoPoint_real;
@property (assign) int threePoint_real;
@property (assign) int ftPoint_real;

- (id)initWithObj:(int)two three:(int)three ft:(int)ft;

- (void)areWeCoolAboutAllTheThing;

@end
