//
//  iBCountViewControllerForHotZoneGestureMode.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-18.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBCountViewControllerForHotZoneGestureMode.h"
#import <UIKit/UIGestureRecognizerSubclass.h>


@interface iBCountViewControllerForHotZoneGestureMode ()

@end

@implementation ZGestureRecognizer

// Implemented in your custom subclass
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swipeLeft:(id)sender {
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
