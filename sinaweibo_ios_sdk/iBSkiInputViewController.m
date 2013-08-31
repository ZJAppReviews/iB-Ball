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
    upv.showsSelectionIndicator = YES;
    upv.delegate = self;
    upv.dataSource = self;
//    [self.view addSubview:upv];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)skillInputOK {
    [self.delegate skillInput:self withName:self.skillText.text withDesctiption:self.skillDescription.text andTag:self.category];
}   



- (void)viewDidUnload {
    [self setSkillText:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (row) {
        case 0:
            return @"进攻技";
            break;
        case 1:
            return @"防守技";
            break;
        default:
            return @"其他";
            break;
    }
}
     
     

//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 3;
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (row == 0) {
        self.category = 1;
    }
    if (row == 1)
        self.category = 2;
    if (row == 2) {
        self.category = 0;
    }
}
@end
