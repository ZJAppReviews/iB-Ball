//
//  iBObjViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObjViewController.h"

@interface iBObjViewController ()

@end

@implementation iBObjViewController

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
    _myPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    _myPicker.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    CGSize pickerSize = [_myPicker sizeThatFits:CGSizeZero];
	_myPicker.frame = [self pickerFrameWithSize:pickerSize];
    _myPicker.showsSelectionIndicator = YES;	// note this is default to NO
    self.myPicker.dataSource = self;
    self.myPicker.delegate = self;

	[self.view addSubview:_myPicker];
    [self.myPicker setHidden:YES];
//    [self.doneButton setacc]

	// Do any additional setup after loading the view.
}

// return the picker frame based on its size, positioned at the bottom of the page
- (CGRect)pickerFrameWithSize:(CGSize)size
{
	CGRect screenRect = [[UIScreen mainScreen] applicationFrame];
	CGRect pickerRect = CGRectMake(	0.0,
                                   screenRect.size.height - size.height,
                                   size.width,
                                   size.height);
	return pickerRect;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)setPoint:(id)sender {
    _myPicker.hidden = NO;
//    UIBarButtonItem *a = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    UIBarButtonItem *a = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = a;
}

- (void)doneButtonClicked {
    self.navigationItem.rightBarButtonItem = nil;
    self.myPicker.hidden = YES;
}
- (void)viewDidUnload {
//    [self setDoneButton:nil];
    [super viewDidUnload];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (row > 50) {
        return [NSString stringWithFormat:@"Take care of yourself...%d", row];
    }
    return [NSString stringWithFormat:@"%d", row];
}
@end
