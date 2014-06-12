//
//  iBObjViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/28/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iBObjDataModel;

@interface iBObjViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate>

- (IBAction)setPoint:(id)sender;

@property (nonatomic, strong) UIPickerView *myPicker;

@property (nonatomic, strong) iBObjDataModel *objModel;

@property (strong, nonatomic) IBOutlet UILabel *l1;
@property (strong, nonatomic) IBOutlet UILabel *l2;
@property (strong, nonatomic) IBOutlet UILabel *l3;

//@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@property (weak, nonatomic) IBOutlet UIButton *backgroundTapButton;

@property (weak, nonatomic) IBOutlet UIButton *rockButton;

@end

