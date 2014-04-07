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

- (IBAction)renrenLog:(id)sender {
    // deal with renren
    Renren *renren = [Renren sharedRenren];
    NSLog(@"%@", renren.accessToken);
    NSArray *permisson= @[@"status_update",@"read_user_feed", @"publish_comment"];
    [renren authorizationWithPermisson:permisson andDelegate:self];
//    NSArray *permissions = [NSArray arrayWithObjects:@"read_user_album",@"status_update",@"photo_upload",@"publish_feed",@"create_album",@"operate_like",nil];

}

- (IBAction)getUserinfo:(id)sender {
    SinaWeibo *sinaweibo = [self sinaweibo];
    [sinaweibo requestWithURL:@"users/show.json" params:[NSMutableDictionary dictionaryWithObject:sinaweibo.userID forKey:@"uid"] httpMethod:@"GET" delegate:self];
}

- (IBAction)showGameCenter:(id)sender {
    [[GameKitHelper sharedGameKitHelper] showGameCenterViewController];
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

- (IBAction)signIn:(id)sender {
//    if (![PFUser currentUser]) { // No user logged in
//        // Create the log in view controller
//        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
//        [logInViewController setDelegate:self]; // Set ourselves as the delegate
//        
//        // Create the sign up view controller
//        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
//        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
//        
//        // Assign our sign up controller to be displayed from the login controller
//        [logInViewController setSignUpController:signUpViewController];
//        
//        // Present the log in view controller
//        [self presentViewController:logInViewController animated:YES completion:NULL];
//    }
}

//// Sent to the delegate to determine whether the log in request should be submitted to the server.
//- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
//    // Check if both fields are completed
//    if (username && password && username.length != 0 && password.length != 0) {
//        return YES; // Begin login process
//    }
//    
//    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
//                                message:@"Make sure you fill out all of the information!"
//                               delegate:nil
//                      cancelButtonTitle:@"ok"
//                      otherButtonTitles:nil] show];
//    return NO; // Interrupt login process
//}
//
//// Sent to the delegate when a PFUser is logged in.
//- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
//    [self dismissViewControllerAnimated:YES completion:NULL];
//}
//
//- (IBAction)logout:(id)sender {
//    [PFUser logOut];
//}
//

#pragma mark - RenrenDelegate methods

@end
