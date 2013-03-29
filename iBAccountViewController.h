//
//  iBAccountViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/25/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import <Parse/Parse.h>

@interface iBAccountViewController : UIViewController <SinaWeiboDelegate, SinaWeiboRequestDelegate, PFSignUpViewControllerDelegate, PFLogInViewControllerDelegate>
{
NSDictionary *userInfo;
NSArray *statuses;

}

- (IBAction)weiboLog:(id)sender;

- (IBAction)getUserinfo:(id)sender;

@end