//
//  EditStudentsTableViewController.m
//  Ob Log
//
//  Created by David Alkire on 11/17/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define TEXTFIELD_LAST_OLD      223164
#define TEXTFIELD_LAST_TEMP     223165
#define TEXTFIELD_LAST_NEW      223166
#define TEXTFIELD_FIRST_OLD     223167
#define TEXTFIELD_FIRST_TEMP    223168
#define TEXTFIELD_FIRST_NEW     223169

#import "EditStudentsTableViewController.h"

@implementation EditStudentsTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize course = _course;
@synthesize studentsArray = _studentsArray;
@synthesize studentsCoreDataArray = _studentsCoreDataArray;
@synthesize mayAddRow = _mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style andCourse:(Course *)crs
{
    self = [super initWithStyle:style];
    if (self) {
        _managedObjectContext = [CoreDataHelperFunctions managedObjectContext];
        _studentsArray = [[NSMutableArray alloc] initWithCapacity:0];
        _studentsCoreDataArray = [[NSMutableArray alloc] initWithArray:[CoreDataHelperFunctions fetchStudentsForCourse:crs]];
        _course = crs;
        [self loadStudentsArray];
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self 
                                                                                action:@selector(didTouchEditButton)];
        [self.navigationItem setRightBarButtonItem:editBtn];
        [self.navigationItem setTitle:[crs courseTitle]];
        [self.tableView setEditing:NO];
        [self didTouchEditButton];
    }
    return self;
}

- (void)loadStudentsArray
{
    NSMutableArray *stu = [[NSMutableArray alloc] initWithCapacity:0];
    int len = [_studentsCoreDataArray count];
    for (int i = 0; i < len; i++) {
        [stu addObject:[NSString stringWithFormat:@"%@, %@", [(Student *)[_studentsCoreDataArray objectAtIndex:i] lastName], [(Student *)[_studentsCoreDataArray objectAtIndex:i] firstName]]];
    }
    [self setStudentsArray:stu];
    [stu release];
    [self.tableView reloadData];
    NSLog(@"OpCD: %@", _studentsCoreDataArray);
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
    
    NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[_studentsArray count] inSection:0], nil];
    [_studentsArray addObject:@"zzzAdd_Studentzzz"];
    Student *student = (Student *)[NSEntityDescription 
                                            insertNewObjectForEntityForName:@"Student" 
                                            inManagedObjectContext:_managedObjectContext];
    [student setFirstName:@""];
    [student setLastName:@""];
    [student addCoursesObject:_course];
    [_studentsCoreDataArray addObject:student];
    [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView setEditing:YES];
    [self.tableView reloadData];
}

- (void)didTouchDoneButton
{
    int len = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < len; i++) {
        NSString *strFirst = @"";
        NSString *strLast = @"";
        
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if ([cell viewWithTag:TEXTFIELD_LAST_OLD]) {
            strFirst = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_OLD]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_OLD]).text : @""];
            strLast = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_OLD]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_OLD]).text : @""];
            [_studentsArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@, %@", strLast, strFirst]];
            [(Student *)[_studentsCoreDataArray objectAtIndex:i] setFirstName:strFirst];
            [(Student *)[_studentsCoreDataArray objectAtIndex:i] setLastName:strLast];
        }
        else if ([cell viewWithTag:TEXTFIELD_LAST_TEMP]) {
            strFirst = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_TEMP]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_TEMP]).text : @""];
            strLast = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_TEMP]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_TEMP]).text : @""];
            [_studentsArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%@, %@", strLast, strFirst]];
            [(Student *)[_studentsCoreDataArray objectAtIndex:i] setFirstName:strFirst];
            [(Student *)[_studentsCoreDataArray objectAtIndex:i] setLastName:strLast];
        }
        else if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_LAST_NEW]) {
            strFirst = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_NEW]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_FIRST_NEW]).text : @""];
            strLast = [NSString stringWithFormat:@"%@", ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_NEW]).text ? ((UITextField *)[cell viewWithTag:TEXTFIELD_LAST_NEW]).text : @""];
            if ([strFirst isEqualToString:@""] && [strLast isEqualToString:@""]) {
                [_studentsArray removeObjectAtIndex:i];
                [_managedObjectContext deleteObject:(Student *)[_studentsCoreDataArray objectAtIndex:i]];
                [_studentsCoreDataArray removeObjectAtIndex:i];
            }
        }
        NSLog(@">>FIRST: %@, LAST: %@", strFirst, strLast);
        
        [cell.textLabel setHidden:NO];
        //[cell release];
    }
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                            target:self 
                                                                            action:@selector(didTouchEditButton)];
    [self.navigationItem setRightBarButtonItem:editBtn];
    [editBtn release];
    [self.tableView setEditing:NO];
    [self.tableView reloadData];
    [self saveStudents];
    NSLog(@"OpCD: %@", _studentsCoreDataArray);
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_studentsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [cell.textLabel setText:[_studentsArray objectAtIndex:indexPath.row]];
    
    if (self.tableView.editing) {
        [cell.textLabel setHidden:YES];
        
        if ([cell viewWithTag:TEXTFIELD_FIRST_OLD]) {
            NSLog(@"found textfield first old");
        }
        
        UITextField *tfFirst = [[UITextField alloc] initWithFrame:CGRectMake(10, 
                                                                             11, 
                                                                             121, 
                                                                             24)];
        [tfFirst setBackgroundColor:[UIColor colorWithRed:(float)0xF7/0xFF 
                                                    green:(float)0xF7/0xFF 
                                                     blue:(float)0xF7/0xFF 
                                                    alpha:1]];
        [tfFirst setFont:[UIFont boldSystemFontOfSize:17]];
        UITextField *tfLast = [[UITextField alloc] initWithFrame:CGRectMake(141, 
                                                                            11, 
                                                                            121, 
                                                                            24)];
        [tfLast setBackgroundColor:[UIColor colorWithRed:(float)0xF7/0xFF 
                                                   green:(float)0xF7/0xFF 
                                                    blue:(float)0xF7/0xFF 
                                                   alpha:1]];
        [tfLast setFont:[UIFont boldSystemFontOfSize:17]];
        
        [tfFirst setPlaceholder:@"First Name"];
        [tfFirst setTag:TEXTFIELD_FIRST_NEW];
        [tfLast setPlaceholder:@"Last Name"];
        [tfLast setTag:TEXTFIELD_LAST_NEW];
        
        if ([[_studentsArray objectAtIndex:indexPath.row] isEqualToString:@"zzzAdd_Studentzzz"]) {
            NSLog(@"FOUND ADD STUDENT CELL");
            [tfFirst setText:@""];
            [tfLast setText:@""];
        }
        else {
            [tfFirst setText:[(Student *)[_studentsCoreDataArray objectAtIndex:indexPath.row] firstName]];
            [tfFirst setTag:TEXTFIELD_FIRST_OLD];
            [tfLast setText:[(Student *)[_studentsCoreDataArray objectAtIndex:indexPath.row] lastName]];
            [tfLast setTag:TEXTFIELD_LAST_OLD];
        }
        
        [tfFirst setDelegate:self];
        [cell.contentView addSubview:tfFirst];
        [tfLast setDelegate:self];
        [cell.contentView addSubview:tfLast];
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    else {
        if ([cell viewWithTag:TEXTFIELD_LAST_OLD]) {
            [[cell viewWithTag:TEXTFIELD_LAST_OLD] setHidden:YES];
        }
        else if ([cell viewWithTag:TEXTFIELD_LAST_TEMP]) {
            [[cell viewWithTag:TEXTFIELD_LAST_TEMP] setHidden:YES];
        }
        else if ([cell viewWithTag:TEXTFIELD_LAST_NEW]) {
            [[cell viewWithTag:TEXTFIELD_LAST_NEW] setHidden:YES];
        }
        if ([cell viewWithTag:TEXTFIELD_FIRST_OLD]) {
            [[cell viewWithTag:TEXTFIELD_FIRST_OLD] setHidden:YES];
        }
        else if ([cell viewWithTag:TEXTFIELD_FIRST_TEMP]) {
            [[cell viewWithTag:TEXTFIELD_FIRST_TEMP] setHidden:YES];
        }
        else if ([cell viewWithTag:TEXTFIELD_FIRST_NEW]) {
            [[cell viewWithTag:TEXTFIELD_FIRST_NEW] setHidden:YES];
        }
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
        [cell setShowsReorderControl:NO];
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
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
        [_studentsArray removeObjectAtIndex:indexPath.row];
        [_managedObjectContext deleteObject:[_studentsCoreDataArray objectAtIndex:indexPath.row]];
        [_studentsCoreDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self saveStudents];
        NSLog(@"-OpCD: %@", _studentsCoreDataArray);
    }
}

// Override to support rearranging the table view.
/*- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [_studentsArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    [_studentsCoreDataArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    
    int len = [_studentsCoreDataArray count];
    for (int i = 0; i < len; i++) {
        [(Student *)[_studentsCoreDataArray objectAtIndex:i] setPosition:[NSNumber numberWithInt:i]];
    }
}*/

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    //[tableView reloadData];
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    
    return YES;
}

#pragma mark - Table view delegate

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected %@", [(Student *)[_studentsCoreDataArray objectAtIndex:[indexPath indexAtPosition:1]] headerText]);
    OptionChoicesTableViewController *choicesTVC = [[OptionChoicesTableViewController alloc] initWithStyle:UITableViewStyleGrouped andOptionHeader:(OptionHeader *)[_optionsCoreDataArray objectAtIndex:[indexPath indexAtPosition:1]]];
    [self.navigationController pushViewController:choicesTVC animated:YES];
}*/

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    int news = 0;
    int len = [self.tableView numberOfRowsInSection:0];
    for (int i = 0; i < len; i++) {
        if ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_LAST_NEW]) {
            news++;
        }
    }
    if (textField.tag == TEXTFIELD_LAST_NEW) {
        _mayAddRow = YES;
    }
    else {
        _mayAddRow = NO;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"TEXTFIELD CHANGE TAG = %d", textField.tag);
    if (_mayAddRow) {
        int pos = [_studentsArray count];
        NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:pos inSection:0], nil];
        [_studentsArray addObject:@"zzzAdd_Studentzzz"];
        Student *student = (Student *)[NSEntityDescription 
                                            insertNewObjectForEntityForName:@"Student" 
                                            inManagedObjectContext:_managedObjectContext];
        [student setFirstName:@""];
        [student setLastName:@""];
        [student addCoursesObject:_course];
        [_studentsCoreDataArray addObject:student];
        [self.tableView insertRowsAtIndexPaths:row withRowAnimation:UITableViewRowAnimationBottom];
        _mayAddRow = NO;
    }
    NSMutableString *str = [NSMutableString stringWithString:[textField text]];
    [str replaceCharactersInRange:range withString:string];
    if ([str isEqualToString:@""]) {
        /*if (textField.tag == TEXTFIELD_FIRST_OLD || textField.tag == TEXTFIELD_FIRST_TEMP || textField.tag == TEXTFIELD_FIRST_NEW) {
            [textField setTag:TEXTFIELD_FIRST_NEW];
        }
        else {
            [textField setTag:TEXTFIELD_LAST_NEW];
        }*/
        
        int len = [self.tableView numberOfRowsInSection:0];
        for (int i = 0; i < len; i++) {
            UITextField *tfF = (UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_FIRST_NEW];
            UITextField *tfL = (UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_LAST_NEW];
            if (tfF && tfL && ![tfF isEqual:textField] && ![tfL isEqual:textField]) {
                [_studentsArray removeObjectAtIndex:i];
                [_studentsCoreDataArray removeObjectAtIndex:i];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:i inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
                _mayAddRow = YES;
            }
        }
    }
    else {
        if (textField.tag == TEXTFIELD_FIRST_OLD || textField.tag == TEXTFIELD_FIRST_NEW) {
            [textField setTag:TEXTFIELD_FIRST_TEMP];
        }
        else if (textField.tag == TEXTFIELD_LAST_OLD || textField.tag == TEXTFIELD_LAST_NEW) {
            [textField setTag:TEXTFIELD_LAST_TEMP];
        }
    }
    
    return TRUE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"DID END EDITING");
    [self saveStudents];
    NSLog(@"~OpCD: %@", _studentsCoreDataArray);
}

#pragma mark - Save data

- (void)saveStudents
{
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
}

@end
