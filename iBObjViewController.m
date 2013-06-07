//
//  iBObjViewController.m
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBObjViewController.h"
#import "iBObj_DataModel.h"
#import "iBObjCountViewController.h"

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
    // customize the rock button
    UIImage *buttonBackground = [UIImage imageNamed:@"whiteButton.png"];
    UIImage *buttonBackgroundPressed = [UIImage imageNamed:@"blueButton.png"];

    UIImage *newImage = [buttonBackground stretchableImageWithLeftCapWidth:10.0 topCapHeight:10];
    [self.rockButton setBackgroundImage:newImage forState:UIControlStateNormal];
    UIImage *newnewImage = [buttonBackgroundPressed stretchableImageWithLeftCapWidth:10.0 topCapHeight:10];
    [self.rockButton setBackgroundImage:newnewImage forState:UIControlStateHighlighted];
    
    _objModel = [[iBObj_DataModel alloc] init];
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

int mark;
- (IBAction)setPoint:(UIView *)sender {
    mark = sender.tag;
    _myPicker.hidden = NO;
//    UIBarButtonItem *a = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    UIBarButtonItem *a = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = a;
}


- (void)doneButtonClicked {
    self.navigationItem.rightBarButtonItem = nil;
    self.myPicker.hidden = YES;
//    NSLog(@"%d", mark);
//    switch (mark) {
//        case 1:
//            _l1.text = [NSString stringWithFormat:@"%d", self.myPicker];
//            break;
//            
//        default:
//            break;
//    }
}
- (void)viewDidUnload {
//    [self setDoneButton:nil];
    [self setL1:nil];
    [self setL2:nil];
    [self setL3:nil];
    [self setBackgroundTapButton:nil];
    [self setBackgroundTapButton:nil];
    [self setRockButton:nil];
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

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (mark) {
        case 1:
            _l1.text = [NSString stringWithFormat:@"%d", row];
            [self.objModel setTwoPoint_Obj:row];
            break;
        case 2:
            _l2.text = [NSString stringWithFormat:@"%d", row];
            [self.objModel setThreePoint_Obj:row];
            break;
        case 3:
            _l3.text = [NSString stringWithFormat:@"%d", row];
            [self.objModel setFtPoint_Obj:row];
            break;

    }
}
//
//- (iBObj_DataModel *)objModel {
//    if (_objModel == nil) {
//        return [[iBObj_DataModel alloc] init];
//    } else {
//        return _objModel;
//    }
//}


- (IBAction)letsRock:(id)sender {
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    iBObjCountViewController *a = (iBObjCountViewController *)segue.destinationViewController;
    [a setDataModel:self.objModel];
}

- (IBAction)showPickerView:(id)sender {
    mark = [sender tag];
    
    // Uses the default UIPickerView frame.
    self.myPicker = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    // Place the Pickerview off the bottom of the screen, in the middle.
    _myPicker.center = CGPointMake([[UIScreen mainScreen] bounds].size.width / 2.0, [[UIScreen mainScreen] bounds].size.height + _myPicker.frame.size.height);
    _myPicker.dataSource = self;
    _myPicker.delegate = self;
    _myPicker.showsSelectionIndicator = YES;
    
    // Create the toolbar and place it at -44, so it rests "above" the pickerview.
    // Borrowed from @Spark, thanks!
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, -44, 320, 44)];
    pickerDateToolbar.barStyle = UIBarStyleBlackTranslucent;
    [pickerDateToolbar sizeToFit];
    
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
    
    // The action can whatever you want, but it should dimiss the picker.
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backgroundTapped:)];
    [barItems addObject:doneBtn];
    
    [pickerDateToolbar setItems:barItems animated:YES];
    [_myPicker addSubview:pickerDateToolbar];
    
    // If you have a UITabBarController, you should add the picker as a subview of it
    // so it appears to go over the tabbar, not under it. Otherwise you can add it to
    // self.view
    [self.tabBarController.view addSubview:_myPicker];
    
    // Animate it moving up
    [UIView animateWithDuration:.3 animations:^{
        [_myPicker setCenter:CGPointMake(160, [[UIScreen mainScreen] bounds].size.height - 110)]; //148 seems to put it in place just right.
    } completion:^(BOOL finished) {
        // When done, place an invisible button on the view behind the picker, so if the
        // user "taps to dismiss" the picker, it will go away. Good user experience!
        self.backgroundTapButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backgroundTapButton.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        [_backgroundTapButton addTarget:self action:@selector(backgroundTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_backgroundTapButton];
    }];
    
}

// And lastly, the method to hide the picker.  You should handle the picker changing
// in a method with UIControlEventValueChanged on the pickerview.
- (void)backgroundTapped:(id)sender {
    
    [UIView animateWithDuration:.3 animations:^{
        _myPicker.center = CGPointMake(160, [[UIScreen mainScreen] bounds].size.height + _myPicker.frame.size.height);
    } completion:^(BOOL finished) {
        [_myPicker removeFromSuperview];
        self.myPicker = nil;
        [self.backgroundTapButton removeFromSuperview];
        self.backgroundTapButton = nil;
    }];
}


@end
