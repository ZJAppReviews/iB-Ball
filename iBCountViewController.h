
//
//  ibCountViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountModel.h"

@interface iBCountViewController : UIViewController

@property (nonatomic, strong) CountModel *countModel;
- (IBAction)score:(id)sender;
- (IBAction)miss:(id)sender;

- (void)updateRatio:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *shootingRatio;
@end
