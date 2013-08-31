//
//  iBSkiTableViewController.m
//  iB-Ball
//
//  Created by apple on 13-3-17.
//  Copyright (c) 2013年 Snowmanzzz. All rights reserved.
//

#import "iBSkiTableViewController.h"
#import "iBSkillDataModel.h"
#import "iBSkill.h"
#import "iBSkiCountViewController.h"

@interface iBSkiTableViewController ()

@end

@implementation iBSkiTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    self.skillModel = [[iBSkillDataModel alloc] init];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addItem:)];
//    self.navigationItem.leftBarButtonItem = addButton;

}

- (void)bbiClicked {
    [self.tableView moveSection:0 toSection:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.skillModel.attackSkills count];
    }
    if (section == 1) {
        return [self.skillModel.defendingSkills count];
    }
    if (section == 2) {
        return [self.skillModel.otherSkills count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (indexPath.section == 0) {
    // Configure the cell...
        cell.textLabel.text = ((iBSkill *)self.skillModel.attackSkills[indexPath.row]).skillName;
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
//    [cell.contentView addGestureRecognizer:longPress];
//    if (indexPath.section == 1) {
//        UITableViewCell *cell2 = [UITableViewCell new];
//        UIPickerView *upv = [UIPickerView new];
//        [cell2 addSubview:upv];
//        return cell2;
//    }
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = ((iBSkill *)self.skillModel.defendingSkills[indexPath.row]).skillName;
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = ((iBSkill *)self.skillModel.otherSkills[indexPath.row]).skillName;
    }
    
    return cell;
}

- (void)longPress {
//    NSLog(@"Bingo!");
    iBSkill *skill = [self.skillModel.skillArray objectAtIndex:self.selected];
//    NSLog(skill.description);
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wow" message:[NSString stringWithFormat:@"This killer's score is %d/%d", skill.successNumber, skill.useNumber ] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.skillModel.skillArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    iBSkill *temp = [self.skillModel.skillArray objectAtIndex:fromIndexPath.row];
    [self.skillModel.skillArray removeObjectAtIndex:fromIndexPath.row];
    [self.skillModel.skillArray insertObject:temp atIndex:toIndexPath.row];
    [self.tableView reloadData];
}


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self isEditing]) {
        NSLog(@"ss");
    }
    self.selected = indexPath.row;
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"Please choose" delegate:self cancelButtonTitle:@"OK" destructiveButtonTitle:nil otherButtonTitles:@"Statics", @"Description", @"Count", @"Edit", nil];
    [as showFromTabBar:self.tabBarController.tabBar];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"addSkill"]) {
        iBSkiInputViewController *a = (iBSkiInputViewController *)segue.destinationViewController;
        a.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"count"]) {
        iBSkiCountViewController *a = (iBSkiCountViewController *)segue.destinationViewController;
        iBSkill *b = [self.skillModel.skillArray objectAtIndex:self.selected];
        a.whichSkill = b;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
//    NSLog(@"%@", self.skillModel.skillArray);
}

- (void)skillInput:(id)sender withName:(NSString *)name withDesctiption:(NSString *)description andTag:(iBSkillCategory)skillCategory {
    iBSkill *newSkill = [[iBSkill alloc] initWithName:name andDescrip:description andTag:skillCategory];
    [self.skillModel addSkill:newSkill];
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark Action sheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self longPress];
    }
    if (buttonIndex == 2) {
        // segue to count
//        iBSkiCountViewController *a = [[iBSkiCountViewController alloc] init];
//        UIStoryboardSegue *i = [[UIStoryboardSegue alloc] initWithIdentifier:@"skiCount" source:self destination:a];
//        [i perform];
        iBSkiCountViewController *a = [[iBSkiCountViewController alloc] initWithNibName:@"iBSkiCountView" bundle:nil];
        a.whichSkill = [self.skillModel.skillArray objectAtIndex:self.selected];
        [self.navigationController pushViewController:a animated:YES];
    }
    if (buttonIndex == 1) {
        iBSkill *currentSkill = [self.skillModel.skillArray objectAtIndex:self.selected];
        NSLog(@"%@", currentSkill.skillName);
        if (currentSkill.skillDescription == nil) {
            // let the user say
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Cool" message:@"please input your description" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
            av.alertViewStyle = UIAlertViewStylePlainTextInput;
            [av show];
            return;
        }
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:currentSkill.skillName message:currentSkill.skillDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [av show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        // ok
        iBSkill *currentSkill = [self.skillModel.skillArray objectAtIndex:self.selected];
        currentSkill.skillDescription = [alertView textFieldAtIndex:0].text;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"进攻技";
    }
    else if (section == 1) {
        return @"防守技";
    }
    else if (section == 2) {
        return @"其他";
    }
}

@end
