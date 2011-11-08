//
//  OptionPickersTableViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/18/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define EDIT_TEXTFIELD 223164

#import "OptionPickersTableViewController.h"

@implementation OptionPickersTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize optionsArray = _optionsArray;
@synthesize myEditing = _myEditing;
@synthesize mayAddRow = _mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _optionsArray = [[NSMutableArray alloc] initWithCapacity:0];
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                 target:self 
                                                                 action:@selector(didTouchEditButton)];
        [self.navigationItem setRightBarButtonItem:editBtn];
        [self setTitle:@"Option Sets"];
        _myEditing = NO;
    }
    return self;
}

- (void)loadOptionPickers
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"OptionHeader" inManagedObjectContext:_managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"headerText" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [request setEntity:entity];
    [request setSortDescriptors:sortDescriptors];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[_managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success..");
        NSMutableArray *ops = [[NSMutableArray alloc] initWithCapacity:0];
        int len = [mutableFetchResults count];
        for (int i = 0; i < len; i++) {
           [ops addObject:[(OptionHeader *)[mutableFetchResults objectAtIndex:i] headerText]];
        }
        [self setOptionsArray:ops];
        [ops release];
        [self.tableView reloadData];
    }
}

- (void)didTouchEditButton
{
    NSLog(@"DID touch edit btn");
    //[self.tableView setEditing:YES animated:YES];
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                            target:self 
                                                                            action:@selector(didTouchDoneButton)];
    [self.navigationItem setRightBarButtonItem:doneBtn];
    [doneBtn release];
    NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[_optionsArray count] inSection:0], nil];
    [_optionsArray addObject:@"zzzAdd_Option_Pickerzzz"];
    [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationNone];
    _myEditing = YES;
    [self.tableView reloadData];
}

- (void)didTouchDoneButton
{
    int len = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < len; i++) {
        if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:EDIT_TEXTFIELD]) {
            NSString *str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:EDIT_TEXTFIELD]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:EDIT_TEXTFIELD]).text : @""];
            if ([str isEqualToString:@""]) {
                [_optionsArray removeObjectAtIndex:i];
            }
            else {
                [_optionsArray replaceObjectAtIndex:i withObject:str];
            }
        }
    }
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                            target:self 
                                                                            action:@selector(didTouchEditButton)];
    [self.navigationItem setRightBarButtonItem:editBtn];
    [editBtn release];
    _myEditing = NO;
    [self.tableView reloadData];
    [self saveOptionChoices];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"VIEW WILL APPEAR");
    [self setContentSizeForViewInPopover:CGSizeMake(320, 440)];
    [self loadOptionPickers];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_optionsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.textLabel setText:[_optionsArray objectAtIndex:indexPath.row]];
    
    if (_myEditing) {
        //[_optionsArray replaceObjectAtIndex:indexPath.row withObject:@""];
        //[cell.textLabel setText:@""];
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 
                                                                        11, 
                                                                        282, 
                                                                        24)];
        [tf setBackgroundColor:[UIColor colorWithRed:(float)0xF7/0xFF 
                                               green:(float)0xF7/0xFF 
                                                blue:(float)0xF7/0xFF 
                                               alpha:1]];
        [tf setFont:[UIFont boldSystemFontOfSize:17]];
        if ([[_optionsArray objectAtIndex:indexPath.row] isEqualToString:@"zzzAdd_Option_Pickerzzz"]) {
            [tf setPlaceholder:@"Add Option Set"];
            [tf setText:@""];
        }
        else {
            [tf setText:[_optionsArray objectAtIndex:indexPath.row]];
        }
        [tf setDelegate:self];
        [tf setTag:EDIT_TEXTFIELD];
        [cell.contentView addSubview:tf];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        if ([cell viewWithTag:EDIT_TEXTFIELD]) {
            [[cell viewWithTag:EDIT_TEXTFIELD] removeFromSuperview];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"[_optionsArray count] = %d", [_optionsArray count]);
    if (indexPath.row == [_optionsArray count] - 1) {
        return NO;
    }
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < [_optionsArray count] - 1) {
        return UITableViewCellEditingStyleDelete;
    }
    
    return UITableViewCellEditingStyleNone;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_optionsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
    NSLog(@"COMMIT EDITING");
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView reloadData];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _mayAddRow = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (_mayAddRow) {
        NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[_optionsArray count] inSection:0], nil];
        [_optionsArray addObject:@"zzzAdd_Option_Pickerzzz"];
        [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationBottom];
        _mayAddRow = NO;
    }
    NSMutableString *str = [NSMutableString stringWithString:[textField text]];
    [str replaceCharactersInRange:range withString:string];
    if ([str isEqualToString:@""]) {
        int len = [self.tableView numberOfRowsInSection:0];
        for (int i = 0; i < len; i++) {
            if ([((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:EDIT_TEXTFIELD]).text isEqualToString:@""]) {
                [_optionsArray removeObjectAtIndex:i];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                NSLog(@"------&&&&&******####$$$$!!!!");
                _mayAddRow = YES;
            }
        }
    }
    
    return TRUE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"DID END EDITING");
}

#pragma mark - Save data

- (void)saveOptionChoices
{
    
    OptionHeader *header = (OptionHeader *)[NSEntityDescription 
                                insertNewObjectForEntityForName:@"OptionHeader" 
                                inManagedObjectContext:_managedObjectContext];
    [header setHeaderText:@"text"];
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
}

@end
