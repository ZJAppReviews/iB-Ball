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
#import "iBDataCenterForHotzone.h"

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
//    if (self.whatKindOfGestureReconizingAreWeIn == GestureForObjective) {
//        
//        if (self.dataModelForObj.twoPoint_real <= 0) {
//            return;
//        }
//        self.dataModelForObj.twoPoint_real--;
//        NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModelForObj.twoPoint_real];
//        [self.view makeToast:toastMessage];
//    }
//    if (self.whatKindOfGestureReconizingAreWeIn == GestureForTwoCount) {
//        self.dataModelForTwo.shootingTimes++;
//        self.dataModelForTwo.goalTimes++;
//    }
    switch (self.whatKindOfGestureReconizingAreWeIn) {
        case GestureForObjective:
            
        {
            if (self.dataModelForObj.twoPoint_real <= 0) {
                return;
            }
            self.dataModelForObj.twoPoint_real--;
            NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModelForObj.twoPoint_real];
            [self.view makeToast:toastMessage];
        }
            break;
            
        case GestureForTwoCount:
        {
            self.dataModelForTwo.totalGoalTimes++;
            self.dataModelForTwo.totalShootingTimes++;
            self.dataModelForTwo.shootingTimes++;
            self.dataModelForTwo.goalTimes++;
            NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModelForTwo.goalTimes];
            [self.view makeToast:toastMessage];

        }
    }
}

- (IBAction)swipeRight:(id)sender {
    if (self.whatKindOfGestureReconizingAreWeIn == GestureForObjective) {
        
        //    NSLog(@"yeah right");
        if (self.dataModelForObj.twoPoint_real < 0) {
            return;
        }
        self.dataModelForObj.twoPoint_real++;
        NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModelForObj.twoPoint_real];
        [self.view makeToast:toastMessage];
    }
    
    if (self.whatKindOfGestureReconizingAreWeIn == GestureForTwoCount) {
        self.dataModelForTwo.totalShootingTimes++;
        self.dataModelForTwo.shootingTimes++;
        NSString *toastMessage = [NSString stringWithFormat:@"twoPoint: %d", self.dataModelForTwo.goalTimes];
        [self.view makeToast:toastMessage];

    }
    
}

//- (IBAction)swipeDown:(id)sender {
//    self.dataModel.threePoint_real++;
//    NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModel.threePoint_real];
//    NSLog(toastMessage);
//    [self.view makeToast:toastMessage];
//
//}
- (IBAction)swipeDown:(id)sender {
    //    switch (self.whatKindOfGestureReconizingAreWeIn) {
    //        case GestureForObjective:
    ////
    //            self.dataModelForObj.threePoint_real++;
    //            NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModelForObj.threePoint_real];
    //            //    NSLog(toastMessage);
    //            [self.view makeToast:toastMessage];
    //            NSLog(@"s");
    //            break;
    //            case GestureForTwoCount:
    //            break;
    //    }
    if (self.whatKindOfGestureReconizingAreWeIn == GestureForObjective) {
        self.dataModelForObj.threePoint_real++;
        NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModelForObj.threePoint_real];
        //    NSLog(toastMessage);
        [self.view makeToast:toastMessage];
        
    }
    if (self.whatKindOfGestureReconizingAreWeIn == GestureForTwoCount) {
        return;
    }
    
}

- (IBAction)swipeUp:(id)sender {
    if (self.whatKindOfGestureReconizingAreWeIn == GestureForObjective) {
        
        if (self.dataModelForObj.threePoint_real <= 0) {
            return;
        }
        self.dataModelForObj.threePoint_real--;
        NSString *toastMessage = [NSString stringWithFormat:@"threePoint: %d", self.dataModelForObj.threePoint_real];
        [self.view makeToast:toastMessage];
    }
}

- (IBAction)doubleTap:(id)sender {
    self.dataModelForObj.ftPoint_real++;
    NSString *toastMessage = [NSString stringWithFormat:@"free throw: %d", self.dataModelForObj.ftPoint_real];
    [self.view makeToast:toastMessage];
}

- (IBAction)tripleTap:(id)sender {
    if (self.dataModelForObj.ftPoint_real <= 0) {
        return;
    }
    self.dataModelForObj.ftPoint_real--;
    NSString *toastMesage = [NSString stringWithFormat:@"free throw: %d", self.dataModelForObj.ftPoint_real];
    [self.view makeToast:toastMesage];
    
}

- (void)viewDidUnload {
    [self setDoubleGesture:nil];
    [self setThribleGesture:nil];
    [super viewDidUnload];
}


@end
