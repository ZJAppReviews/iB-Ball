//
//  iBAccountViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 3/25/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBAccountViewController.h"
#import "SinaWeibo.h"
#import "iBAppDelegate.h"

@implementation iBAccountViewController

- (IBAction)weiboLog:(id)sender {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    NSLog(@"%@", [keyWindow subviews]);
    SinaWeibo *sinaweibo = [self sinaweibo];
    sinaweibo.delegate = self;
    [sinaweibo logIn];
}

- (IBAction)getUserinfo:(id)sender {
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

- (SinaWeibo *)sinaweibo {
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    return delegate.sinaweibo;
}

- (void)storeAuthData
{
    SinaWeibo *sinaweibo = self.sinaweibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    
//    [self resetButtons];
    [self storeAuthData];
}

//- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
//{
//    NSLog(@"sinaweiboDidLogOut");
//    [self removeAuthData];
//    [self resetButtons];
//}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

////- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
////{
////    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
////    [self removeAuthData];
////    [self resetButtons];
//}

#pragma mark - SinaWeiboRequest Delegate
//
//- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
//{
//    if ([request.url hasSuffix:@"users/show.json"])
//    {
//        [userInfo release], userInfo = nil;
//    }
//    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
//    {
//        [statuses release], statuses = nil;
//    }
//    else if ([request.url hasSuffix:@"statuses/update.json"])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", postStatusText]
//                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alertView show];
//        [alertView release];
//        
//        NSLog(@"Post status failed with error : %@", error);
//    }
//    else if ([request.url hasSuffix:@"statuses/upload.json"])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", postImageStatusText]
//                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alertView show];
//        [alertView release];
//        
//        NSLog(@"Post image status failed with error : %@", error);
//    }
//    
//    
//    [self resetButtons];
//}
//
//- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
//{
//    if ([request.url hasSuffix:@"users/show.json"])
//    {
//        [userInfo release];
//        userInfo = [result retain];
//    }
//    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
//    {
//        [statuses release];
//        statuses = [[result objectForKey:@"statuses"] retain];
//    }
//    else if ([request.url hasSuffix:@"statuses/update.json"])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
//                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alertView show];
//        [alertView release];
//        
//        [postStatusText release], postStatusText = nil;
//    }
//    else if ([request.url hasSuffix:@"statuses/upload.json"])
//    {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
//                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
//                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
//        [alertView show];
//        [alertView release];
//        
//        [postImageStatusText release], postImageStatusText = nil;
//    }
//    
//    [self resetButtons];
//}


- (void)viewDidUnload {
    [super viewDidUnload];
}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
        userInfo = result;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
        statuses = [result objectForKey:@"statuses"];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
//        postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
//        [postImageStatusText release], postImageStatusText = nil;
    }
    
//    [self resetButtons];
    NSLog(@"%@", userInfo);
}
@end
