//
//  iBChoosePositionViewController.m
//  iB-Ball
//
//  Created by Snowmanzzz on 13-9-5.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBChoosePositionViewController.h"

@interface iBChoosePositionViewController ()

@end

@implementation iBChoosePositionViewController

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
    self.positionTable.delegate = self;
    self.positionTable.dataSource = self;
    
    self.position = [[NSUserDefaults standardUserDefaults] objectForKey:@"position"];
    if (self.position == nil) {
        self.position = [NSMutableArray new];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *tableCell;
    
    
    
    switch (indexPath.row) {
        case 0:
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            tableCell.textLabel.text = @"C";
            
            if (![self.position containsObject:@"C"]) {
                tableCell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                tableCell.accessoryType = UITableViewCellAccessoryCheckmark;

            }
            break;
            
        case 1:
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            tableCell.textLabel.text = @"PF";
            
            if (![self.position containsObject:@"PF"]) {
                tableCell.accessoryType = UITableViewCellAccessoryNone;
            } else {
                tableCell.accessoryType = UITableViewCellAccessoryCheckmark;
            }

            break;

        case 2:
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            tableCell.textLabel.text = @"SF";

            
            if (![self.position containsObject:@"SF"]) {
                tableCell.accessoryType = UITableViewCellAccessoryNone;

            } else {
                tableCell.accessoryType = UITableViewCellAccessoryCheckmark;

            }
            break;

        case 3:
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            tableCell.textLabel.text = @"SG";
            
            
            if (![self.position containsObject:@"SG"]) {
                tableCell.accessoryType = UITableViewCellAccessoryNone;

            } else {
                tableCell.accessoryType = UITableViewCellAccessoryCheckmark;

            }
            break;

        case 4:
            
            tableCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
            tableCell.textLabel.text = @"PG";

            if (![self.position containsObject:@"PG"]) {
                tableCell.accessoryType = UITableViewCellAccessoryNone;

            } else {
                tableCell.accessoryType = UITableViewCellAccessoryCheckmark;

            }

            
            break;



            
        default:
            break;
    }
    return tableCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
//    NSLog(@"%d", indexPath.row);


    switch (indexPath.row) {
        case 0:
            if ([self.position containsObject:@"C"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.position removeObject:@"C"];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.position addObject:@"C"];
            }
            break;
            
        case 1:
            if ([self.position containsObject:@"PF"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.position removeObject:@"PF"];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.position addObject:@"PF"];
            }
            break;
        case 2:
            if ([self.position containsObject:@"SF"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.position removeObject:@"SF"];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.position addObject:@"SF"];
            }
            break;
        case 3:
            if ([self.position containsObject:@"SG"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.position removeObject:@"SG"];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.position addObject:@"SG"];
            }
            break;
        case 4:
            if ([self.position containsObject:@"PG"]) {
                cell.accessoryType = UITableViewCellAccessoryNone;
                [self.position removeObject:@"PG"];
            } else {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                [self.position addObject:@"PG"];
            }
            break;

        default:
            break;
    }
    
    [self.positionTable reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSUserDefaults standardUserDefaults] setObject:self.position forKey:@"position"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
