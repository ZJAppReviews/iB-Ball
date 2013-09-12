//
//  iBZGestureReconizer.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-7.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIGestureRecognizerSubclass.h>


@interface iBZGestureReconizer : UIGestureRecognizer

- (void)reset;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@property BOOL strokeInflectionOne;
@property BOOL strokeInflectionTwo;

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint secondPoint;
@property (nonatomic) CGPoint thirdPoint;



@end
