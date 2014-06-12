//
//  iBObjCountViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 3/1/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iBObjDataModel;

@interface iBObjCountViewController : UIViewController

@property (nonatomic, strong) iBObjDataModel *dataModel;

@property (strong, nonatomic) IBOutlet UILabel *l1;
@property (strong, nonatomic) IBOutlet UILabel *l2;
@property (strong, nonatomic) IBOutlet UILabel *l3;


@end
