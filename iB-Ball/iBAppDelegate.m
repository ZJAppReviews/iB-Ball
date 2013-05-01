//
//  iBAppDelegate.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/8/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBAppDelegate.h"
#import "SinaWeibo.h"
#import "AFNetworkActivityIndicatorManager.h"
#import <Parse/Parse.h>

@implementation iBAppDelegate

@synthesize sinaweibo;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES);
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];

    // Override point for customization after application launch.
//    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_viewController];
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSLog(@"%@", defaults.dictionaryRepresentation);
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
    
    [Parse setApplicationId:@"FahVYM3v6LhX87eKNvz3Sed7nTiWrfVmOSNtKcX2"
                  clientKey:@"qmKyKDkcGVttjLdapr0m0AWk4iHJ7XnxwfdequyO"];
//    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    

    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    

    return YES;
}

- (void)renrenDidLogin:(Renren *)renren {
    
}
- (void)renrenDidLogout:(Renren *)renren {
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
