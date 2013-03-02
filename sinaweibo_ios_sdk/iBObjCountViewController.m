//
//  iBObjCountViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 3/1/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObjCountViewController.h"
#import "iBObj_DataModel.h"

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
@end
