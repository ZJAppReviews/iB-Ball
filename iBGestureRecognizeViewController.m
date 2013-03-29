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
    [self.doubleGesture requireGestureRecognizerToFail:self.thribleGesture];
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

//- (IBAction)swipeDown:(id)sender {
//    self.dataModel.threePoint_real++;
//    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
//    NSLog(toastMessage);
//    [self.view makeToast:toastMessage];
//
//}
- (IBAction)swipeDown:(id)sender {
    self.dataModel.threePoint_real++;
    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
//    NSLog(toastMessage);
    [self.view makeToast:toastMessage];

}

- (IBAction)swipeUp:(id)sender {
    self.dataModel.threePoint_real--;
    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
    [self.view makeToast:toastMessage];

}

- (IBAction)doubleTap:(id)sender {
    self.dataModel.ftPoint_real++;
    NSString *toastMessage = [NSString stringWithFormat:@"free throw: %d", self.dataModel.ftPoint_real];
    [self.view makeToast:toastMessage];
}

- (IBAction)tripleTap:(id)sender {
    self.dataModel.ftPoint_real--;
    NSString *toastMesage = [NSString stringWithFormat:@"free throw: %d", self.dataModel.ftPoint_real];
    [self.view makeToast:toastMesage];

}

- (void)viewDidUnload {
    [self setDoubleGesture:nil];
    [self setThribleGesture:nil];
    [super viewDidUnload];
}
@end
