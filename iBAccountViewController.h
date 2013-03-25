//
//  iBAccountViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/25/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface iBAccountViewController : UIViewController <SinaWeiboDelegate, SinaWeiboRequestDelegate>
{
NSDictionary *userInfo;
NSArray *statuses;

}

- (IBAction)weiboLog:(id)sender;

- (IBAction)getUserinfo:(id)sender;

@end
