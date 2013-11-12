//
//  iBChartsViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-11-10.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBChartsViewController.h"
#import "iBAppDelegate.h"
#import "PNColor.h"
#import "PNChart.h"

@interface iBChartsViewController ()

@end

@implementation iBChartsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    iBAppDelegate *delegate = (iBAppDelegate *)[UIApplication sharedApplication].delegate;
    self.managedObjectContext = delegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"TwoPoint"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"twoPointDay"
                                                                   ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        // Handle the error
    }
    
    NSArray *dateArray = [fetchedObjects valueForKey:@"twoPointDay"];
    NSArray *twoPointGoal = [fetchedObjects valueForKey:@"twoPointGoal"];
    NSArray *twoPointTotal = [fetchedObjects valueForKey:@"twoPointTotal"];
    NSMutableArray *ratioArray = [NSMutableArray new];
    for (int i = 0; i < twoPointGoal.count; i++) {
        NSInteger a = [twoPointGoal[i] integerValue];
        NSInteger b = [twoPointTotal[i] integerValue];
        CGFloat bc = (CGFloat)a / b;
        NSString *c = [NSString stringWithFormat:@"%f", bc];
        [ratioArray addObject:c];
    }
//    //Add LineChart
//	UILabel * lineChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
//	lineChartLabel.text = @"Line Chart";
//	lineChartLabel.textColor = PNFreshGreen;
////	lineChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
//	lineChartLabel.textAlignment = NSTextAlignmentCenter;
//	
//	PNChart * lineChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 75.0, SCREEN_WIDTH, 200.0)];
//	lineChart.backgroundColor = [UIColor clearColor];
//	[lineChart setXLabels:dateArray];
//	[lineChart setYValues:ratioArray];
//	[lineChart strokeChart];
//	[self.view addSubview:lineChartLabel];
    UILabel * barChartLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 30)];
	barChartLabel.text = @"2pt Trend";
	barChartLabel.textColor = PNFreshGreen;
	barChartLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:23.0];
	barChartLabel.textAlignment = NSTextAlignmentCenter;
	
	PNChart * barChart = [[PNChart alloc] initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 200.0)];
	barChart.backgroundColor = [UIColor clearColor];
	barChart.type = PNLineType;
	[barChart setXLabels:dateArray];
	[barChart setYValues:ratioArray];
	[barChart strokeChart];
	[self.view addSubview:barChartLabel];
	[self.view addSubview:barChart];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
