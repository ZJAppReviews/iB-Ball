//
//  iBHotzoneStaticsDetailController.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-10-16.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBHotzoneStaticsDetailController : UIViewController <RenrenDelegate>

@property (nonatomic) NSInteger hotzoneTag;

@property (weak, nonatomic) IBOutlet UIView *buttonsView;

@property (strong, nonatomic) UIImage *shareImage;

@end
