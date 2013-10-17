//
//  iBHotzoneStaticsDetailController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-10-16.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBHotzoneStaticsDetailController.h"

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
    
}


@end
