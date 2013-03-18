//
//  iBSkiCountViewController.m
//  iB-Ball
//
//  Created by apple on 3/19/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBSkiCountViewController.h"
#import "iBSkill.h"

@interface iBSkiCountViewController ()

@end

@implementation iBSkiCountViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)plusOne:(id)sender {
    self.whichSkill.successNumber++;
    self.whichSkill.useNumber++;
}

- (IBAction)minusOne:(id)sender {
    self.whichSkill.useNumber++;
}

@end
