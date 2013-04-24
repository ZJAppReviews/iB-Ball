//
//  iBCountingSelectViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 4/5/13.
//  Copyright (c) 2013 Snowmanzzz. All rights reserved.
//

#import "iBCountingSelectViewController.h"
#import "iBGestureRecognizeViewController.h"
#import "iBCountViewController.h"

@interface iBCountingSelectViewController ()

@end

@implementation iBCountingSelectViewController

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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 4) {
        iBGestureRecognizeViewController *a = [[iBGestureRecognizeViewController alloc] initWithNibName:@"iBGestureRecognizeViewController" bundle:nil];
        a.whatKindOfGestureReconizingAreWeIn = GestureForMatchCount;
        [self presentViewController:a animated:YES completion:nil];
        
    }
    if (indexPath.row == 2) {
        self.rowIndexThatWeSelect = 2;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    iBCountViewController *a = (iBCountViewController *)[(UINavigationController *)segue.destinationViewController topViewController];

    if ([segue.identifier isEqualToString:@"2ptCounting"]) {
        a.whatTypeOfCountingAreWeIn = CountForTwo;
    }
    if ([segue.identifier isEqualToString:@"3ptCounting"]) {

        a.whatTypeOfCountingAreWeIn = CountForThree;
    }
    if ([segue.identifier isEqualToString:@"NormalCounting"]) {
        a.whatTypeOfCountingAreWeIn = CountForNormal;
    }
}

@end
