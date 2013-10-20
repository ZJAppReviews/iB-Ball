//
//  iBShowPersonStaticViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-3.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBShowPersonStaticViewController.h"
#import "iBChoosePositionViewController.h"
#import "UIBezierPath+ShadowPath.h"
#import "Renren.h"

@interface iBShowPersonStaticViewController ()

@end

@implementation iBShowPersonStaticViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
            [self shareToRenren];
            break;
        case 1:
            [self saveToAlbumAndGetThePic];
            
        default:
            break;
    }
}

- (void)action{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"Share to Renren", @"Save to Album", nil];
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)shareToRenren {
    [self saveToAlbumAndGetThePic];
    if (self.shareImage) {
        [[Renren sharedRenren] publishPhotoSimplyWithImage:self.shareImage caption:@"--From iB-Ball"];
    } else {
        NSLog(@"cant find the pic");
    }
}

- (void)saveToAlbumAndGetThePic {
    UIView *view = self.view;
    CGSize imageSize = [self.view bounds].size;
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // -renderInContext: renders in the coordinate space of the layer,
    // so we must first apply the layer's geometry to the graphics context
    CGContextSaveGState(context);
    // Center the context around the view's anchor point
    CGContextTranslateCTM(context, [view center].x, [view center].y);
    // Apply the view's transform about the anchor point
    CGContextConcatCTM(context, [view transform]);
    // Offset by the portion of the bounds left of and above the anchor point
    CGContextTranslateCTM(context,
                          -[view bounds].size.width * [[view layer] anchorPoint].x,
                          -[view bounds].size.height * [[view layer] anchorPoint].y);
    
    // Render the layer hierarchy to the current context
    [[view layer] renderInContext:context];
    
    // Restore the context
    CGContextRestoreGState(context);
    
    // Retrieve the screenshot image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    self.shareImage = image;
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(action)];

    // Do any additional setup after loading the view from its nib.
    self.userAvatar.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    self.userAvatar.layer.borderWidth = 2.0;
    self.userAvatar.layer.shadowOffset = CGSizeMake(0, 3);
    self.userAvatar.layer.shadowOpacity = 0.7;
    self.userAvatar.layer.shouldRasterize = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCurvedShadowForRect:self.userAvatar.bounds];
    self.userAvatar.layer.shadowPath = path.CGPath;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choosePosition:(id)sender {
    iBChoosePositionViewController *ibcp = [[iBChoosePositionViewController alloc] initWithNibName:@"iBChoosePositionViewController" bundle:nil];
    [self.navigationController pushViewController:ibcp animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"position"];
    NSMutableString *str = [NSMutableString new];
    for (NSString *string in array) {
        [str appendString:string];
        [str appendString:@","];
    }
    self.positionLabel.text = str;
    
    self.nameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}

- (IBAction)nameFieldChanged:(id)sender {
    NSString *name = self.nameTextField.text;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction)tapView:(id)sender {
    [self.nameTextField resignFirstResponder];
}

@end
