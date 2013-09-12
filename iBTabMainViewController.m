//
//  iBTabMainViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-24.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBTabMainViewController.h"
#import "CustomTabBar.h"

@interface iBTabMainViewController ()

- (void) addTabBarArrow;

@end

@implementation iBTabMainViewController
@synthesize tabBarArrow;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    self.delegate = self;
    
    self.navigationController.delegate = self;
    [self addTabBarArrow];
}

- (void)addTabBarArrow {
    UIImage *tabBarArrowImage = [UIImage imageNamed:@"TabBarNipple.png"];
    self.tabBarArrow = [[UIImageView alloc] initWithImage:tabBarArrowImage];
    CGFloat verticalLocation = [UIScreen mainScreen].bounds.size.height - tabBarArrowImage.size.height - self.tabBarBar.frame.size.height + 2;
    tabBarArrow.frame = CGRectMake([self horizontalLocationFor:0], verticalLocation, tabBarArrowImage.size.width, tabBarArrowImage.size.height);
    [self.view addSubview:self.tabBarArrow];
}

- (CGFloat) horizontalLocationFor:(NSUInteger)tabIndex
{
    // A single tab item's width is the entire width of the tab bar divided by number of items
    CGFloat tabItemWidth = self.tabBarBar.frame.size.width / self.tabBarBar.items.count;
    // A half width is tabItemWidth divided by 2 minus half the width of the arrow
    CGFloat halfTabItemWidth = (tabItemWidth / 2.0) - (tabBarArrow.frame.size.width / 2.0);
    
    // The horizontal location is the index times the width plus a half width
    return (tabIndex * tabItemWidth) + halfTabItemWidth;
}

- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    CGRect frame = tabBarArrow.frame;
    frame.origin.x = [self horizontalLocationFor:self.selectedIndex];
    tabBarArrow.frame = frame;
    [UIView commitAnimations];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

// Called when the navigation controller shows a new top view controller via a push, pop or setting of the view controller stack.
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"ss");

}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSLog(@"ssa");

}

@end
