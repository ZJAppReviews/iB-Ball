//
//  iBSkiInputViewController.h
//  iB-Ball
//
//  Created by apple on 3/18/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBSkill.h"

@protocol SkillInputOK <NSObject>

- (void)skillInput:(id)sender withName:(NSString *)name withDesctiption:(NSString *)description andTag:(iBSkillCategory)skillCategory;

@end

@interface iBSkiInputViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *skillText;
@property (weak, nonatomic) IBOutlet UITextField *skillDescription;


@property (nonatomic, strong) id<SkillInputOK> delegate;

@property (weak, nonatomic) IBOutlet UIPickerView *skillCategoryInput;
@property (nonatomic) NSInteger category;

@end

