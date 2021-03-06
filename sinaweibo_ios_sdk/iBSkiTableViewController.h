//
//  iBSkiTableViewController.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBSkiInputViewController.h"

@class iBSkillDataModel;

@interface iBSkiTableViewController : UITableViewController <UITableViewDataSource, SkillInputOK, UIActionSheetDelegate, UIAlertViewDelegate, RenrenDelegate>

@property (nonatomic, strong) iBSkillDataModel *skillModel;

@property (nonatomic, strong) NSIndexPath *selected;

- (iBSkill *)getSelectedSkill;

@end
