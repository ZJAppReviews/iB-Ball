//
//  iBGestureRecognizeViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 3/27/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBGestureRecognizeViewController.h"
#import "iBObj_DataModel.h"
#import "Toast+UIView.h"

@implementation iBGestureRecognizeViewController

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

- (IBAction)dismiss:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)swipeLeft:(id)sender {
//    NSLog(@"yeah left");
    if (self.dataModel.twoPoint_real <= 0) {
        return;
    }
    self.dataModel.twoPoint_real--;
    NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModel.twoPoint_real];
    [self.view makeToast:toastMessage];
}

- (IBAction)swipeRight:(id)sender {
//    NSLog(@"yeah right");
    if (self.dataModel.twoPoint_real < 0) {
        return;
    }
    self.dataModel.twoPoint_real++;
    NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModel.twoPoint_real];
    [self.view makeToast:toastMessage];

}

- (IBAction)swipeDown:(id)sender {
    self.dataModel.threePoint_real++;
    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
    [self.view makeToast:toastMessage];

}

- (IBAction)swipeUp:(id)sender {
    if (self.dataModel.threePoint_real <= 0) {
        return;
    }
    self.dataModel.threePoint_real--;
    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
    [self.view makeToast:toastMessage];

}
@end
