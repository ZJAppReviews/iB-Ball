//
//  iBCountViewControllerForHotZoneGestureMode.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-18.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol iBCountViewControllerForHotZoneGestureMode <NSObject>

- (void)gestureInfoChange:(NSInteger)number1 and:(NSInteger)number2;

@end

@interface ZGestureRecognizer : UIGestureRecognizer
- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
@interface iBCountViewControllerForHotZoneGestureMode : UIViewController <UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger numberWeScore;
@property (nonatomic) NSInteger numberWeTry;

@property (nonatomic, weak) id<iBCountViewControllerForHotZoneGestureMode> delegate;
@end

