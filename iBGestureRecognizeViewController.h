//
//  iBGestureRecognizeViewController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 3/27/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "iBObj_DataModel.h"
@class iBDataCenterForHotzone;

typedef enum {
    GestureForObjective = 1,
    GestureForTwoCount,
    GestureForThreeCount,
    GestureForMatchCount
} GestureType;

@class iBObj_DataModel;

@interface iBGestureRecognizeViewController : UIViewController <UIGestureRecognizerDelegate>

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *doubleGesture;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *thribleGesture;


- (IBAction)swipeLeft:(id)sender;

- (IBAction)swipeRight:(id)sender;

- (IBAction)swipeDown:(id)sender;

- (IBAction)swipeUp:(id)sender;

@property (nonatomic, weak) iBObj_DataModel *dataModelForObj;
@property (nonatomic, weak) iBDataCenterForHotzone *dataModelForTwo;
// i dont know weather it's good to separate, whatever
@property (nonatomic, weak) iBDataCenterForHotzone *dataModelForThree;

@property (nonatomic, assign) GestureType whatKindOfGestureReconizingAreWeIn;

@end
