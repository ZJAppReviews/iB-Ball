//
//  iBObjCountViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 3/1/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObjCountViewController.h"
#import "iBObj_DataModel.h"
#import "iBSharedAchievement.h"
#import "iBGestureRecognizeViewController.h"


@interface iBObjCountViewController ()

@end

@implementation iBObjCountViewController

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
	// Do any additional se   bh         
//    NSLog(@"reduce three");
}


- (IBAction)reduceTwoPoint:(id)sender {
    if (self.dataModel.twoPoint_real <= 0) {
        return;
    }
    self.dataModel.twoPoint_real--;
    [self updateLabel];
}

- (IBAction)reduceFTPoint:(id)sender {
//    NSLog(@"reduce ft");
    if (self.dataModel.ftPoint_real <= 0) {
        return;
    }
    self.dataModel.ftPoint_real--;
    [self updateLabel];

}

- (void)viewDidUnload {
    [self setL1:nil];
    [self setL2:nil];
    [self setL3:nil];
    [super viewDidUnload];
}

- (void)checkAchieve {
    [[iBSharedAchievement sharedAchievement] checkToSeeTheAchievement:self.view];
}

- (IBAction)startRecognize:(id)sender {
    iBGestureRecognizeViewController *a = [[iBGestureRecognizeViewController alloc] initWithNibName:@"iBGestureRecognizeViewController" bundle:nil];
    a.dataModel = self.dataModel;
    [self presentModalViewController:a animated:YES];
}


@end
