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


@class SinaWeibo;



@interface iBShareViewController : UIViewController <SinaWeiboDelegate, SinaWeiboRequestDelegate> {
    NSDictionary *userInfo;
    NSArray *statuses;
    NSString *postStatusText;
    NSString *postImageStatusText;
    int ia;
}

//@property (strong, readonly, nonatomic) SinaWeibo *sinaweibo;
@property (strong, nonatomic) SinaWeibo *sinaweibo;

@property (nonatomic, assign) int shoot;
@property (nonatomic, assign) int goal;

@end
