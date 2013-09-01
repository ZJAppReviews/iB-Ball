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
	// Do any additional setup after loading the view.
    NSLog(@"Now in countViewController");
    NSLog(@"the three: %d", [[self dataModel] twoPoint_real]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPoint:(UIView *)sender {
    switch (sender.tag) {
        case 1:
            self.dataModel.twoPoint_real++;
            [iBSharedAchievement sharedAchievement].twoPointCurrent++;
            int i = [iBSharedAchievement sharedAchievement].twoPointCurrent;
            int j = [iBSharedAchievement sharedAchievement].twoPointGoal;
            NSLog(@"%d %d", i, j);
            [[iBSharedAchievement sharedAchievement] checkToSeeTheAchievement:self.view];
            [self checkAchieve];
            break;
        case 2:
            self.dataModel.threePoint_real++;
            break;
        case 3:
            self.dataModel.ftPoint_real++;
            break;
    }
    [self.dataModel areWeCoolAboutAllTheThing];
    [self updateLabel];
}

- (void)updateLabel {
    _l1.text = [NSString stringWithFormat:@"%d/%d", self.dataModel.twoPoint_real, self.dataModel.twoPoint_Obj];
    _l2.text = [NSString stringWithFormat:@"%d/%d", self.dataModel.threePoint_real, self.dataModel.threePoint_Obj];
    _l3.text = [NSString stringWithFormat:@"%d/%d", self.dataModel.ftPoint_real, self.dataModel.ftPoint_Obj];
}


- (IBAction)reduceThreePoint:(id)sender {
    if (self.dataModel.threePoint_real <= 0) {
        return;
    }
    self.dataModel.threePoint_real--;
    [self updateLabel];
    
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
    a.dataModelForObj = self.dataModel;
    [self presentModalViewController:a animated:YES];
}


@end
