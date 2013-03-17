//
//  iBSkiTableViewController.h
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iBSkillDataModel;

@interface iBSkiTableViewController : UITableViewController <UITableViewDataSource>

@property (nonatomic, strong) iBSkillDataModel *skillModel;
@end
