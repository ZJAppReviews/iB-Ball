//
//  iBTabMainViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-24.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBTabMainViewController.h"

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
//    [self addTabBarArrow];
    
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
