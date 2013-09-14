//
//  iBHotzoneShowStaticsViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 5/17/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBHotzoneShowStaticsViewController.h"

@interface iBHotzoneShowStaticsViewController ()

@end

@implementation iBHotzoneShowStaticsViewController

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

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)showStatics:(id)sender {
    int tagValue = ((UIView *)sender).tag;
    NSString *tagKey = [NSString stringWithFormat:@"%d", tagValue];
    NSArray *a = [[NSUserDefaults standardUserDefaults] objectForKey:tagKey];
    if (a == nil) {
        return;
    }
    NSNumber *n1 = [a objectAtIndex:0];
    NSNumber *n2 = [a objectAtIndex:1];
    
    NSString *desc = @"You shoot ";
    desc = [desc stringByAppendingFormat:@"%d, and you score %d", [n2 integerValue], [n1 integerValue]];
    float ratio = (float)n1.integerValue / n2.integerValue * 100;
    desc = [desc stringByAppendingFormat:@"your ratio is : %.2f %%", ratio];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ratio" message:desc delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

@end
