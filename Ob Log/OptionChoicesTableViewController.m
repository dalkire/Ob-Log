//
//  OptionChoicesTableViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define TEXTFIELD_OLD   223164
#define TEXTFIELD_TEMP  223165
#define TEXTFIELD_NEW   223166

#import "OptionChoicesTableViewController.h"

@implementation OptionChoicesTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize optionHeader = _optionHeader;
@synthesize optionChoicesCoreDataArray = _optionChoicesCoreDataArray;
@synthesize optionChoicesArray = _optionChoicesArray;
@synthesize mayAddRow = _mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style andOptionHeader:(OptionHeader *)oh
{
    self = [super initWithStyle:style];
    if (self) {
        _optionHeader = oh;
        _optionChoicesCoreDataArray = [[NSMutableArray alloc] initWithArray:[CoreDataHelperFunctions fetchOptionChoicesForOptionHeader:_optionHeader]];
        _optionChoicesArray = [[NSMutableArray alloc] initWithCapacity:0];
        _managedObjectContext = [CoreDataHelperFunctions managedObjectContext];
        
        int len = [_optionChoicesCoreDataArray count];
        for (int i = 0; i < len; i++) {
            [_optionChoicesArray addObject:[(OptionChoice *)[_optionChoicesCoreDataArray objectAtIndex:i] choiceText]];
        }
        
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self 
                                                                                action:@selector(didTouchEditButton)];
        [self.navigationItem setRightBarButtonItem:editBtn];
        [self setTitle:[_optionHeader headerText]];
        [self.tableView setEditing:NO];
        NSLog(@"Choices for header \"%@\": %@", [oh headerText], _optionChoicesCoreDataArray);
    }
    return self;
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

- (void)didTouchEditButton
{
    NSLog(@"DID touch edit btn");
    UIBarButtonItem *doneBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                            target:self 
                                                                            action:@selector(didTouchDoneButton)];
    [self.navigationItem setRightBarButtonItem:doneBtn];
    [doneBtn release];
    int pos = [_optionChoicesArray count];
    NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:pos inSection:0], nil];
    [_optionChoicesArray addObject:@"zzzAdd_Option_Choicezzz"];
    OptionChoice *choice = (OptionChoice *)[NSEntityDescription 
                                            insertNewObjectForEntityForName:@"OptionChoice" 
                                            inManagedObjectContext:_managedObjectContext];
    [choice setChoiceText:@""];
    [choice setPosition:[NSNumber numberWithInt:pos]];
    [choice setOptionHeader:_optionHeader];
    [_optionChoicesCoreDataArray addObject:choice];
    [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView setEditing:YES];
    [self.tableView reloadData];
}

- (void)didTouchDoneButton
{
    int len = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < len; i++) {
        NSString *str = @"";
        if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_OLD]) {
            str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_OLD]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_OLD]).text : @""];
            [_optionChoicesArray replaceObjectAtIndex:i withObject:str];
            [(OptionChoice *)[_optionChoicesCoreDataArray objectAtIndex:i] setChoiceText:str];
        }
        else if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]) {
            str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]).text : @""];
            [_optionChoicesArray replaceObjectAtIndex:i withObject:str];
            [(OptionChoice *)[_optionChoicesCoreDataArray objectAtIndex:i] setChoiceText:str];
        }
        else if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]) {
            str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]).text : @""];
            if ([str isEqualToString:@""]) {
                [_optionChoicesArray removeObjectAtIndex:i];
                [_managedObjectContext deleteObject:(OptionChoice *)[_optionChoicesCoreDataArray objectAtIndex:i]];
                [_optionChoicesCoreDataArray removeObjectAtIndex:i];
            }
        }
    }
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                            target:self 
                                                                            action:@selector(didTouchEditButton)];
    [self.navigationItem setRightBarButtonItem:editBtn];
    [editBtn release];
    [self.tableView setEditing:NO];
    [self.tableView reloadData];
    [self saveOptionChoices];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_optionChoicesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.textLabel setText:[_optionChoicesArray objectAtIndex:indexPath.row]];
    
    if (self.tableView.editing) {
        //[_optionsArray replaceObjectAtIndex:indexPath.row withObject:@""];
        //[cell.textLabel setText:@""];
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 
                                                                        11, 
                                                                        262, 
                                                                        24)];
        [tf setBackgroundColor:[UIColor colorWithRed:(float)0xF7/0xFF 
                                               green:(float)0xF7/0xFF 
                                                blue:(float)0xF7/0xFF 
                                               alpha:1]];
        [tf setFont:[UIFont boldSystemFontOfSize:17]];
        if ([[_optionChoicesArray objectAtIndex:indexPath.row] isEqualToString:@"zzzAdd_Option_Choicezzz"]) {
            [tf setPlaceholder:@"Add Option Choice"];
            [tf setText:@""];
            [tf setTag:TEXTFIELD_NEW];
        }
        else {
            [tf setText:[_optionChoicesArray objectAtIndex:indexPath.row]];
            [tf setTag:TEXTFIELD_OLD];
        }
        [tf setDelegate:self];
        [cell.contentView addSubview:tf];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        if ([cell viewWithTag:TEXTFIELD_OLD]) {
            [[cell viewWithTag:TEXTFIELD_OLD] removeFromSuperview];
        }
        else if ([cell viewWithTag:TEXTFIELD_TEMP]) {
            [[cell viewWithTag:TEXTFIELD_TEMP] removeFromSuperview];
        }
        else if ([cell viewWithTag:TEXTFIELD_NEW]) {
            [[cell viewWithTag:TEXTFIELD_NEW] removeFromSuperview];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [cell setShowsReorderControl:NO];
    }
    
    return cell;
}- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) {
        return UITableViewCellEditingStyleNone;
    }
    return UITableViewCellEditingStyleDelete;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_optionChoicesArray removeObjectAtIndex:indexPath.row];
        [_managedObjectContext deleteObject:[_optionChoicesCoreDataArray objectAtIndex:indexPath.row]];
        [_optionChoicesCoreDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self saveOptionChoices];
        //NSLog(@"-OpCD: %@", _optionChoicesCoreDataArray);
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [_optionChoicesArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    [_optionChoicesCoreDataArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    
    int len = [_optionChoicesCoreDataArray count];
    for (int i = 0; i < len; i++) {
        [(OptionChoice *)[_optionChoicesCoreDataArray objectAtIndex:i] setPosition:[NSNumber numberWithInt:i]];
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView reloadData];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    
    return YES;
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int news = 0;
    int len = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < len; i++) {
        if ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]) {
            news++;
        }
    }
    if (textField.tag == TEXTFIELD_NEW) {// && news < 1) {
        _mayAddRow = YES;
    }
    else {
        _mayAddRow = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //NSLog(@"textField:%@, range:%@, string:%@", textField, range, string);
    if (_mayAddRow) {
        int pos = [_optionChoicesArray count];
        NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:pos inSection:0], nil];
        [_optionChoicesArray addObject:@"zzzAdd_Option_Choicezzz"];
        OptionChoice *choice = (OptionChoice *)[NSEntityDescription 
                                                insertNewObjectForEntityForName:@"OptionChoice" 
                                                inManagedObjectContext:_managedObjectContext];
        [choice setChoiceText:@""];
        [choice setPosition:[NSNumber numberWithInt:pos]];
        [choice setOptionHeader:_optionHeader];
        [_optionChoicesCoreDataArray addObject:choice];
        [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationBottom];
        _mayAddRow = NO;
    }
    NSMutableString *str = [NSMutableString stringWithString:[textField text]];
    [str replaceCharactersInRange:range withString:string];
    if ([str isEqualToString:@""]) {
        [textField setTag:TEXTFIELD_NEW];
        int len = [self.tableView numberOfRowsInSection:0];
        for (int i = 0; i < len; i++) {
            UITextField *tf = (UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW];
            if (tf && ![tf isEqual:textField]) {
                [_optionChoicesArray removeObjectAtIndex:i];
                [_optionChoicesCoreDataArray removeObjectAtIndex:i];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                _mayAddRow = YES;
            }
        }
    }
    else {
        [textField setTag:TEXTFIELD_TEMP];
    }
    
    return TRUE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"DID END EDITING & textField.text=%@", textField.text);
    [self saveOptionChoices];
    //NSLog(@"~OpCD: %@", _optionChoicesCoreDataArray);
}

#pragma mark - Save data

- (void)saveOptionChoices
{
    NSLog(@":~: %@", [_managedObjectContext insertedObjects]);
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
}

@end
