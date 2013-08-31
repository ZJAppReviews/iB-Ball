//
//  iBCountViewControllerForHotZone.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBCountViewControllerForHotZoneGestureMode.h"

@interface iBCountViewControllerForHotZone : UIViewController <iBCountViewControllerForHotZoneGestureMode>

@property (nonatomic) NSInteger hotzoneTag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) NSInteger numberWeTry;
@property (nonatomic) NSInteger numberWeScore;

@property (nonatomic) NSInteger numberWeTryHistory;
@property (nonatomic) NSInteger numberWeScoreHistory;

- (IBAction)score:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *trainingResult;
@property (strong, nonatomic) IBOutlet UILabel *trainingResultHistory;

@property (strong, nonatomic) NSDictionary *hotzoneDict;



@end
