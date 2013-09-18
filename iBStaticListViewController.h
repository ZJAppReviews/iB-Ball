//
//  iBStaticListViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-3.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBStaticListViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property (weak, nonatomic) IBOutlet UITableViewCell *twoPointCellView;
@property (weak, nonatomic) IBOutlet UITableViewCell *threePointCellView;
@property (weak, nonatomic) IBOutlet UITableViewCell *twoPointDayCell;

@end
