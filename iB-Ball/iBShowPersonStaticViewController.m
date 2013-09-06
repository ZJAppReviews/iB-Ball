//
//  iBShowPersonStaticViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-3.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBShowPersonStaticViewController.h"
#import "iBChoosePositionViewController.h"

@interface iBShowPersonStaticViewController ()

@end

@implementation iBShowPersonStaticViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)choosePosition:(id)sender {
    iBChoosePositionViewController *ibcp = [[iBChoosePositionViewController alloc] initWithNibName:@"iBChoosePositionViewController" bundle:nil];
    [self.navigationController pushViewController:ibcp animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:@"position"];
    NSMutableString *str = [NSMutableString new];
    for (NSString *string in array) {
        [str appendString:string];
        [str appendString:@","];
    }
    self.positionLabel.text = str;
}

@end
