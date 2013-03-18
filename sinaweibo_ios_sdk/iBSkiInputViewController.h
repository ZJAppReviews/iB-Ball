//
//  iBSkiInputViewController.h
//  iB-Ball
//
//  Created by apple on 3/18/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SkillInputOK <NSObject>

- (void)skillInput:(id)sender withName:(NSString *)name;

@end

@interface iBSkiInputViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *skillText;

@property (nonatomic, weak) id<SkillInputOK> delegate;

@end

