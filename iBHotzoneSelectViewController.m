//
//  iBHotzoneSelectViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBHotzoneSelectViewController.h"
#import "iBCountViewController.h"

@interface iBHotzoneSelectViewController ()

@end

@implementation iBHotzoneSelectViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([(UIView *)sender tag] == 99) {
        return;
    }
    iBCountViewController *dest = (iBCountViewController *)segue.destinationViewController;
    dest.whatTypeOfCountingAreWeIn = CountForHotZone;
    dest.hotzoneTag = [(UIView *)sender tag];
    NSLog(@"%d", dest.hotzoneTag);
}

@end
