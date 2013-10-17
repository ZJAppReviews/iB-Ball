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
#import "iBCountViewControllerForHotZone.h"
#import "iBTabMainViewController.h"

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
    
    for (UIView *uiv in self.view.subviews) {
        if ([uiv isKindOfClass:[UIButton class]]) {
            [(UIButton *)uiv addTarget:self action:@selector(showHotzoneVC:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    ((iBTabMainViewController *)self.tabBarController).tabBarArrow.hidden = YES;
    
//	NSString *path;
//	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//	path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"zzzhotzone/"];
//
//    NSDictionary *hotzoneDict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
//    if (hotzoneDict != nil) {
//        [iBDataCenterForHotzone setHotzoneDict:hotzoneDict];
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showHotzoneStatics"]) {
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
}

- (void)showHotzoneVC:(id)sender {
    iBCountViewControllerForHotZone *ibCountViewController = [[iBCountViewControllerForHotZone alloc] initWithNibName:@"iBCountViewControllerForHotZone" bundle:nil];
    ibCountViewController.hotzoneTag = ((UIView *)sender).tag;
    [self.navigationController pushViewController:ibCountViewController animated:YES];
}

- (void)showStaticsView {
}

- (IBAction)showStatics:(id)sender {
    UINavigationBar *thisBar = self.navigationController.navigationBar;
    [thisBar setTintColor:[UIColor redColor]];
    showStatics = 1;
}

- (void)viewWillAppear:(BOOL)animated {
}

@end
