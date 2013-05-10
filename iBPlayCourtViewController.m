//
//  iBPlayCourtViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/9/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBPlayCourtViewController.h"

@interface iBPlayCourtViewController ()

@end

@implementation iBPlayCourtViewController

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
    self.mapView.showsUserLocation = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setMapView:nil];
    [super viewDidUnload];
}
- (IBAction)hereItIsButtonClicked:(id)sender {
}

- (IBAction)helpMeFindOneButtonClicked:(id)sender {
}
@end
