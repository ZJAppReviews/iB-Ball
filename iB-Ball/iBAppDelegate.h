//
//  iBAppDelegate.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/8/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SinaWeibo;

#define kAppKey             @"1450468020"
#define kAppSecret          @"3bc7e3fa0a27a560a8317d475bc13a40"
#define kAppRedirectURI     @"http://www.sina.com"


@interface iBAppDelegate : UIResponder <UIApplicationDelegate, RenrenDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly, nonatomic) SinaWeibo *sinaweibo;


@end
