
//
//  ibCountViewController.h
//  iB-Ball
//
//  Created by Zhengzhong Zhao on 2/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"
#import <CoreData/CoreData.h>
#import "iBCountModelForTwoAndThree.h"
@class iBDataCenterForHotzoneDoc;


@interface iBCountViewController : UIViewController

@property (nonatomic, strong) iBCountModelForTwoAndThree *countModel;
- (IBAction)score:(id)sender;
- (IBAction)miss:(id)sender;

- (void)updateRatio:(id)sender;


@property (weak, nonatomic) IBOutlet UILabel *shootingRatio;

- (IBAction)showCarrerScore:(id)sender;
- (IBAction)saveData:(id)sender;
- (IBAction)loadData:(id)sender;

- (IBAction)share:(id)sender;

@property (strong, nonatomic) NSDictionary *summaryToBePost;

@property (assign, nonatomic) CountType whatTypeOfCountingAreWeIn;


@property (nonatomic,strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, assign) NSInteger hotzoneTag;



@end
