//
//  iBZGestureReconizer.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-7.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBZGestureReconizer.h"

@implementation iBZGestureReconizer
// Implemented in your custom subclass
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    self.startPoint = [[touches anyObject] locationInView:self.view];

    if ([touches count] != 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [super touchesMoved:touches withEvent:event];
    
    if (self.state == UIGestureRecognizerStateFailed) return;
    
    CGPoint nowPoint = [touches.anyObject locationInView:self.view];
//    CGPoint prevPoint = [touches.anyObject previousLocationInView:self.view];
    
    if (nowPoint.x - self.startPoint.x > 100) {
        self.secondPoint = nowPoint;
        self.strokeInflectionOne = YES;
    }
    
    if (self.secondPoint.x - [[touches anyObject] locationInView:self.view].x > 100 && self.strokeInflectionOne) {
        self.strokeInflectionTwo = YES;
    }

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {


    [super touchesEnded:touches withEvent:event];
    if (-self.thirdPoint.x + [[touches anyObject] locationInView:self.view].x > 100 && self.strokeInflectionOne && self.strokeInflectionTwo) {
        self.state = UIGestureRecognizerStateRecognized;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.strokeInflectionOne = NO;
    self.state = UIGestureRecognizerStateFailed;
}

- (void)reset {
    [super reset];
    self.strokeInflectionOne = NO;
    self.strokeInflectionTwo = NO;
}

@end
