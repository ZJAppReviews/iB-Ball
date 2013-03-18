//
//  iBSkiInputViewController.m
//  iB-Ball
//
//  Created by apple on 3/18/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBSkiInputViewController.h"

@interface iBSkiInputViewController ()

@end

@implementation iBSkiInputViewController

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
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(skillInputOK)];
    self.navigationItem.rightBarButtonItem = done;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)skillInputOK {
    [self.delegate skillInput:self withName:self.skillText.text];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setSkillText:nil];
    [super viewDidUnload];
}

@end
