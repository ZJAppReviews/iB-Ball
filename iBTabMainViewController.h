//
//  iBTabMainViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-24.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomTabBar;

@interface iBTabMainViewController : UITabBarController <UITabBarControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet CustomTabBar *tabBarBar;
@property (nonatomic, retain) UIImageView* tabBarArrow;


@end
