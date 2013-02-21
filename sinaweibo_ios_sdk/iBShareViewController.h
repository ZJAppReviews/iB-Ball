//
//  iBShareViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/20/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import "SinaWeiboRequest.h"

#define kAppKey             @"1450468020"
#define kAppSecret          @"3bc7e3fa0a27a560a8317d475bc13a40"
#define kAppRedirectURI     @"http://www.sina.com"


@class SinaWeibo;



@interface iBShareViewController : UIViewController <SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    int ia;
}

@property (readonly, nonatomic) SinaWeibo *sinaweibo;

@end
