//
//  iBAccountViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/25/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
//#import <Parse/Parse.h>

@interface iBAccountViewController : UIViewController <SinaWeiboDelegate, RenrenDelegate, SinaWeiboRequestDelegate>
{
NSDictionary *userInfo;
NSArray *statuses;

}

- (IBAction)weiboLog:(id)sender;
- (IBAction)renrenLog:(id)sender;

- (IBAction)getUserinfo:(id)sender;

- (IBAction)showGameCenter:(id)sender;
@end
