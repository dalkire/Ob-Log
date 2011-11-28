//
//  EditCoursesViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/7/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define TEXTFIELD_OLD       223164
#define TEXTFIELD_TEMP      223165
#define TEXTFIELD_NEW       223166
#define CELL_CONTENT_VIEW   331347

#import "EditCoursesTableViewController.h"

@implementation EditCoursesTableViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize coursesArray = _coursesArray;
@synthesize coursesCoreDataArray = _coursesCoreDataArray;
@synthesize mayAddRow = _mayAddRow;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        _managedObjectContext = [CoreDataHelperFunctions managedObjectContext];
        _coursesArray = [[NSMutableArray alloc] initWithCapacity:0];
        _coursesCoreDataArray = [[NSMutableArray alloc] initWithArray:[CoreDataHelperFunctions fetchCourses]];
        
        int len = [_coursesCoreDataArray count];
        for (int i = 0; i < len; i++) {
            [_coursesArray addObject:[[_coursesCoreDataArray objectAtIndex:i] courseTitle]];
        }
        NSLog(@":: %@", _coursesCoreDataArray);
        self.navigationItem.title = @"Edit Courses";
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self 
                                                                                action:@selector(didTouchEditButton)];
        [self.navigationItem setRightBarButtonItem:editBtn];
        [self.tableView setEditing:NO];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
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
    
    NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:[_coursesArray count] inSection:0], nil];
    [_coursesArray addObject:@"zzzAdd_Coursezzz"];
    Course *course = (Course *)[NSEntityDescription 
                                   insertNewObjectForEntityForName:@"Course" 
                                   inManagedObjectContext:_managedObjectContext];
    [course setCourseTitle:@""];
    
    const float *colorComponents = CGColorGetComponents([Theme getThemeColor].CGColor);
    float r = colorComponents[0]*255;
    float g = colorComponents[1]*255;
    float b = colorComponents[2]*255;
    
    [course setColorR:[NSNumber numberWithFloat:r]];
    [course setColorG:[NSNumber numberWithFloat:g]];
    [course setColorB:[NSNumber numberWithFloat:b]];
    [_coursesCoreDataArray addObject:course];
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
            [_coursesArray replaceObjectAtIndex:i withObject:str];
            [(Course *)[_coursesCoreDataArray objectAtIndex:i] setCourseTitle:str];
        }
        else if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]) {
            str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_TEMP]).text : @""];
            [_coursesArray replaceObjectAtIndex:i withObject:str];
            [(Course *)[_coursesCoreDataArray objectAtIndex:i] setCourseTitle:str];
        }
        else if ([[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]) {
            str = [NSString stringWithFormat:@"%@", ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]).text ? ((UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] viewWithTag:TEXTFIELD_NEW]).text : @""];
            if ([str isEqualToString:@""]) {
                [_coursesArray removeObjectAtIndex:i];
                [_managedObjectContext deleteObject:(Course *)[_coursesCoreDataArray objectAtIndex:i]];
                [_coursesCoreDataArray removeObjectAtIndex:i];
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
    [self saveCourses];
    NSLog(@"OpCD: %@", _coursesCoreDataArray);
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.coursesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    EditCoursesCellContentView *content = [[EditCoursesCellContentView alloc] initWithCourse:[_coursesCoreDataArray objectAtIndex:indexPath.row]];
    [content setTag:CELL_CONTENT_VIEW];
    
    if (![cell viewWithTag:CELL_CONTENT_VIEW]) {
        [cell.contentView addSubview:content];
    }
    else {
        NSLog(@"CELL has CONTENT");
    }
    
    NSLog(@"coursesArray: %@", _coursesArray);
    //[cell.textLabel setText:[_coursesArray objectAtIndex:indexPath.row]];
    
    if (self.tableView.editing) {
        //[_optionsArray replaceObjectAtIndex:indexPath.row withObject:@""];
        //[cell.textLabel setText:@""];
        /*UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(10, 
                                                                        11, 
                                                                        262, 
                                                                        24)];
        [tf setBackgroundColor:[UIColor colorWithRed:(float)0xF7/0xFF 
                                               green:(float)0xF7/0xFF 
                                                blue:(float)0xF7/0xFF 
                                               alpha:1]];
        [tf setFont:[UIFont boldSystemFontOfSize:17]];*/
        if ([[_coursesArray objectAtIndex:indexPath.row] isEqualToString:@"zzzAdd_Coursezzz"]) {
            [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setPlaceholder:@"Add Course"];
            [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setText:@""];
            [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setTag:TEXTFIELD_NEW];
        }
        else {
            [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setText:[_coursesArray objectAtIndex:indexPath.row]];
            [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setTag:TEXTFIELD_OLD];
        }
        [((EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW]).titleField setDelegate:self];
        [(EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW] setUserInteractionEnabled:YES];
    }
    else {
        /*if ([cell viewWithTag:TEXTFIELD_OLD]) {
            [[cell viewWithTag:TEXTFIELD_OLD] removeFromSuperview];
        }
        else if ([cell viewWithTag:TEXTFIELD_TEMP]) {
            [[cell viewWithTag:TEXTFIELD_TEMP] removeFromSuperview];
        }
        else if ([cell viewWithTag:TEXTFIELD_NEW]) {
            [[cell viewWithTag:TEXTFIELD_NEW] removeFromSuperview];
        }*/
        [cell setShowsReorderControl:NO];
        [(EditCoursesCellContentView *)[cell viewWithTag:CELL_CONTENT_VIEW] setUserInteractionEnabled:NO];
    }
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}// Override to support conditional editing of the table view.
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
        [_coursesArray removeObjectAtIndex:indexPath.row];
        [_managedObjectContext deleteObject:[_coursesCoreDataArray objectAtIndex:indexPath.row]];
        [_coursesCoreDataArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        [self saveCourses];
        NSLog(@"-OpCD: %@", _coursesCoreDataArray);
    }
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [_coursesArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    [_coursesCoreDataArray exchangeObjectAtIndex:[fromIndexPath indexAtPosition:1] withObjectAtIndex:[toIndexPath indexAtPosition:1]];
    
    int len = [_coursesCoreDataArray count];
    for (int i = 0; i < len; i++) {
        [(Course *)[_coursesCoreDataArray objectAtIndex:i] setPosition:[NSNumber numberWithInt:i]];
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
    if (_mayAddRow) {
        int pos = [_coursesArray count];
        NSArray *row = [[NSArray alloc] initWithObjects:[NSIndexPath indexPathForRow:pos inSection:0], nil];
        [_coursesArray addObject:@"zzzAdd_Coursezzz"];
        Course *course = (Course *)[NSEntityDescription 
                                        insertNewObjectForEntityForName:@"Course" 
                                        inManagedObjectContext:_managedObjectContext];
        [course setCourseTitle:@""];
        [course setPosition:[NSNumber numberWithInt:pos]];
        [_coursesCoreDataArray addObject:course];
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
                [_coursesArray removeObjectAtIndex:i];
                [_coursesCoreDataArray removeObjectAtIndex:i];
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
    NSLog(@"DID END EDITING");
    [self saveCourses];
    NSLog(@"~OpCD: %@", _coursesCoreDataArray);
}

#pragma mark - Save data

- (void)saveCourses
{
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
}

@end
