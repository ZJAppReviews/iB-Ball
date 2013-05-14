//
//  CustomTabBar.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/13/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "CustomTabBar.h"

@implementation CustomTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self customize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self customize];
    }
    return self;
}

- (void)customize {
    UIImage *tabbarBg = [UIImage imageNamed:@"tabbar-background.png"];
//    UIImage *tabBarSelected = [UIImage imageNamed:@"tabbar-background-pressed.png"];
    [self setBackgroundImage:tabbarBg];
    [self setTintColor:[UIColor orangeColor]];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
