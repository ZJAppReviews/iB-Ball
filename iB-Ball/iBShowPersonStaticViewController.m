//
//  iBShowPersonStaticViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-3.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBShowPersonStaticViewController.h"
#import "iBChoosePositionViewController.h"
#import "UIBezierPath+ShadowPath.h"

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
    self.userAvatar.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:1.0].CGColor;
    self.userAvatar.layer.borderWidth = 5.0;
    self.userAvatar.layer.shadowOffset = CGSizeMake(0, 3);
    self.userAvatar.layer.shadowOpacity = 0.7;
    self.userAvatar.layer.shouldRasterize = YES;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithCurvedShadowForRect:self.userAvatar.bounds];
    self.userAvatar.layer.shadowPath = path.CGPath;

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
    
    self.nameTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}

- (IBAction)nameFieldChanged:(id)sender {
    NSString *name = self.nameTextField.text;
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
