//
//  iBObjViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBObjViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)setPoint:(id)sender;

@property (nonatomic, strong) UIPickerView *myPicker;

//@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end
