
//
//  ibCountViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

//#import "CountModel.h"
@class iBDataCenterForHotzone;
@class iBDataCenterForHotzoneDoc;


typedef enum CountType {
    CountForNormal = 1,
    CountForTwo,
    CountForThree,
} CountType;

@interface iBCountViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate, SinaWeiboRequestDelegate>

@property (nonatomic, strong) iBDataCenterForHotzone *countModel;
- (IBAction)score:(id)sender;
- (IBAction)miss:(id)sender;

- (void)updateRatio:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *shootingRatio;

- (IBAction)showCarrerScore:(id)sender;
- (IBAction)saveData:(id)sender;
- (IBAction)loadData:(id)sender;

- (IBAction)cancel:(id)sender;
- (IBAction)share:(id)sender;

@property (strong, nonatomic) NSDictionary *summaryToBePost;

@property (assign, nonatomic) CountType whatTypeOfCountingAreWeIn;

@end
