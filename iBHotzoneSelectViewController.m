//
//  iBHotzoneSelectViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/14/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBHotzoneSelectViewController.h"
#import "iBCountViewController.h"
#import "iBHotzoneShowStaticsViewController.h"

@interface iBHotzoneSelectViewController () {
    BOOL showStatics;
}
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
//    NSLog(@"initial %d", showStatics);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showHotzoneStatics"]) {
        iBHotzoneShowStaticsViewController *a = (iBHotzoneShowStaticsViewController *)[segue destinationViewController];
        a.dataCenter = [iBDataCenterForHotzone hotzoneDict];
        return;
    }
    if (showStatics) {
        // show the statics
        [self showStaticsView];
        return;
    }
    if ([(UIView *)sender tag] == 99) {
        return;
    }
    iBCountViewController *dest = (iBCountViewController *)segue.destinationViewController;
    dest.whatTypeOfCountingAreWeIn = CountForHotZone;
    dest.hotzoneTag = [(UIView *)sender tag];
    NSLog(@"%d", dest.hotzoneTag);
}

- (void)showStaticsView {
    
}

- (IBAction)showStatics:(id)sender {
    UINavigationBar *thisBar = self.navigationController.navigationBar;
    [thisBar setTintColor:[UIColor redColor]];
    showStatics = 1;
}
@end
