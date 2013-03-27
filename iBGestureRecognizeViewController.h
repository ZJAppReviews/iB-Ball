//
//  iBGestureRecognizeViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/27/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "iBObj_DataModel.h"
@class iBObj_DataModel;

@interface iBGestureRecognizeViewController : UIViewController <UIGestureRecognizerDelegate>

- (IBAction)swipeLeft:(id)sender;

- (IBAction)swipeRight:(id)sender;

- (IBAction)swipeDown:(id)sender;

- (IBAction)swipeUp:(id)sender;

@property (nonatomic, weak) iBObj_DataModel *dataModel;

@end
