//
//  iBHotzoneStaticsDetailController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-10-16.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBHotzoneStaticsDetailController.h"
#import "RenRenShareActivity.h"

@interface iBHotzoneStaticsDetailController ()

@end

@implementation iBHotzoneStaticsDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (UIView *view in self.buttonsView.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            if (self.hotzoneTag == view.tag) {
                [view setBackgroundColor:[UIColor blackColor]];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)share:(id)sender {
    UIGraphicsBeginImageContextWithOptions(self.buttonsView.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.buttonsView.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    self.shareImage = image;
    
    
    int tagValue = ((UIView *)sender).tag;
    NSString *tagKey = [NSString stringWithFormat:@"%d", self.hotzoneTag];
    NSArray *a = [[NSUserDefaults standardUserDefaults] objectForKey:tagKey];
    if (a == nil) {
        return;
    }
    NSNumber *n1 = [a objectAtIndex:0];
    NSNumber *n2 = [a objectAtIndex:1];

    NSString *desc = @"In this area, you shoot ";
    desc = [desc stringByAppendingFormat:@"%d/%d", [n2 integerValue], [n1 integerValue]];
    float ratio = (float)n1.integerValue / n2.integerValue * 100;
    desc = [desc stringByAppendingFormat:@" ratio is : %.2f %%", ratio];

    ROPublishPhotoRequestParam *aa = [[ROPublishPhotoRequestParam alloc] init];
    aa.caption = desc;
    aa.imageFile = self.shareImage;
    
    [[Renren sharedRenren] publishPhoto:aa andDelegate:self];
    
}

- (void)renren:(Renren *)renren requestDidReturnResponse:(ROResponse*)response {
    
}

- (IBAction)action:(id)sender {
    RenRenShareActivity *a = [[RenRenShareActivity alloc] init];
    UIActivity *b = [[UIActivity alloc] init];
    [self addchil]
    UIActivityViewController *uivc = [[UIActivityViewController alloc] initWithActivityItems:[NSArray arrayWithObjects:a, UIActivityTypeAddToReadingList nil] applicationActivities:nil];
    [self presentViewController:uivc animated:YES completion:nil];
}

@end
