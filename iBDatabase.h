//
//  iBDatabase.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface iBDatabase : NSObject

+ (NSMutableArray *)loadHotzoneDocs;
+ (NSString *)nextHotzoneDocPath;

@end
