//
//  iBChoosePositionViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-5.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBChoosePositionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *positionTable;

@property (strong, nonatomic) NSMutableArray *position;

@end
