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
    UIPickerView *upv = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 300, 320, 300)];
    [self.view addSubview:upv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)skillInputOK {
    [self.delegate skillInput:self withName:self.skillText.text];
}

- (void)viewDidUnload {
    [self setSkillText:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}

@end
