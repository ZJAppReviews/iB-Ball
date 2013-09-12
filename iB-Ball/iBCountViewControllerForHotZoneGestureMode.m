//
//  iBCountViewControllerForHotZoneGestureMode.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-18.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBCountViewControllerForHotZoneGestureMode.h"
#import <UIKit/UIGestureRecognizerSubclass.h>
#import "iBZGestureReconizer.h"


@interface iBCountViewControllerForHotZoneGestureMode ()

@end

@implementation iBCountViewControllerForHotZoneGestureMode

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
    iBZGestureReconizer *gest = [[iBZGestureReconizer alloc] initWithTarget:self action:@selector(zGesture)];
    [self.view addGestureRecognizer:gest];
    self.swipeLeft.delegate = self;
}

- (void)zGesture {
    NSLog(@"wow");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(UIGestureRecognizer *)sender {
    self.numberWeScore++;
    self.numberWeTry++;
    NSLog(@"%@", self);
    [self.delegate gestureInfoChange:self.numberWeScore and:self.numberWeTry];
}

- (IBAction)swipeRight:(id)sender {
    self.numberWeTry++;
    NSLog(@"%@", self);
    [self.delegate gestureInfoChange:self.numberWeScore and:self.numberWeTry];
}

- (NSString *)description {
    return [NSString stringWithFormat:@" self.numberWeScore, self.numberWeTry: %d/%d", self.numberWeScore, self.numberWeTry];
}

@end
