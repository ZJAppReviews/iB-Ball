//
//  iBCountViewControllerForHotZone.h
//  iB-Ball
//
//  Created by Snowmanzzz on 13-8-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iBCountViewControllerForHotZone : UIViewController

@property (nonatomic) NSInteger hotzoneTag;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction)score:(id)sender;


@end
