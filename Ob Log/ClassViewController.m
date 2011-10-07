//
//  ClassViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define SEGMENT_LIST    0
#define SEGMENT_HISTORY 1

#import "ClassViewController.h"

@implementation ClassViewController

@synthesize managedObjectContext;
@synthesize nextStudentId;

@synthesize toolbar;
@synthesize segmentedControl;
@synthesize header;
@synthesize scrollView;
@synthesize studentsArray;

- (id)initWithCourse:(Course *)course
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.studentsArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                                   0, 
                                                                   self.view.frame.size.width, 
                                                                   50)];
        [self.toolbar setBarStyle:UIBarStyleDefault];
        self.toolbar.tintColor = [Theme getThemeColor];//self.navigationController.navigationBar.backgroundColor;
        
        segmentedControl = [[UISegmentedControl alloc] 
                            initWithItems:[NSArray arrayWithObjects:@"Students", @"Today", @"History", nil]];
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        segmentedControl.tintColor = [Theme getThemeColor];
        [segmentedControl setSelectedSegmentIndex:SEGMENT_LIST];
        [self setActiveSegment:SEGMENT_LIST];
        [segmentedControl addTarget:self
                             action:@selector(didTouchSegmentedControl)
                   forControlEvents:UIControlEventValueChanged];
        
        UIBarButtonItem *segmentedButtons = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
        
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                   target:self 
                                   action:@selector(didTouchEdit)];
        UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithTitle:@"Add" 
                                                                  style:UIBarButtonItemStyleBordered 
                                                                 target:self 
                                                                 action:@selector(addCourseModal)];
        UIBarButtonItem *titleBtn = [[UIBarButtonItem alloc] initWithTitle:@"Courses" 
                                                                     style:UIBarButtonItemStylePlain 
                                                                    target:self 
                                                                    action:nil];
        UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem	*fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        fixed.width = 23;
        [self.toolbar setItems:[NSArray arrayWithObjects:segmentedButtons, flex, titleBtn, fixed, flex, editBtn, addBtn, nil]];
        [self.view addSubview:self.toolbar];

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
/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success HERE");
    }
    
    self.nextStudentId = 0;
    int len = [mutableFetchResults count];
    for (int i = 0; i < len; i++) {
        if ((NSUInteger)((Student *)[mutableFetchResults objectAtIndex:i]).id > self.nextStudentId) {
            self.nextStudentId = (NSUInteger)((Student *)[mutableFetchResults objectAtIndex:i]).id;
        }
        NSLog(@"%@", ((Course *)[mutableFetchResults objectAtIndex:i]).name);
        [self.studentsArray addObject:(Student *)[mutableFetchResults objectAtIndex:i]];
    }
    self.nextStudentId++;
    
    self.view.backgroundColor = [UIColor colorWithRed:(float)0xEE/0XFF 
                                                green:(float)0xEE/0XFF 
                                                 blue:(float)0xEE/0XFF 
                                                alpha:1];
    
    header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      0, 
                                                      self.view.frame.size.width, 
                                                      80)];
    [header setMaintitleLabelText:@"Students in Class XYZ"];
    header.maintitleLabel.textColor = [Theme getTextColorForColor:header.backgroundColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                self.header.frame.size.height, 
                                                                self.view.frame.size.width, 
                                                                self.view.frame.size.height - 
                                                                self.header.frame.size.height - 40)];
    scrollView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    for (int i = 0; i < len; i++) {
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:[NSString stringWithFormat:@"%@ %@", 
                               ((Student *)[mutableFetchResults objectAtIndex:i]).first_name,
                               ((Student *)[mutableFetchResults objectAtIndex:i]).last_name]];
        [row setDelegate:self];
        [scrollView addSubview:row];
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
    
    [self.view addSubview:scrollView];
    [self.view addSubview:header];
}

- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Touched ClickRow: %@", clickRow);
}

- (void)addStudentModal
{
    AddStudentViewController *addStudentModal = [[AddStudentViewController alloc] initWithNibName:nil bundle:nil];
    [addStudentModal setDelegate:self];
    [addStudentModal setModalPresentationStyle:UIModalPresentationFormSheet];
    [addStudentModal setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addStudentModal animated:YES];
}

- (void)addStudentWithFirstName:(NSString *)firstName lastName:(NSString *)lastName
{
    Student *student = (Student *)[NSEntityDescription 
                                insertNewObjectForEntityForName:@"Student" 
                                inManagedObjectContext:managedObjectContext];
    [student setId:[NSNumber numberWithInt:self.nextStudentId]];
    [student setFirst_name:firstName];
    [student setLast_name:lastName];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
    ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                               [self.studentsArray count]*CELL_HEIGHT, 
                                                               self.view.frame.size.width, 
                                                               CELL_HEIGHT)];
    [row setMainLabelText:[NSString stringWithFormat:@"%@ %@", firstName, lastName]];
    [row setDelegate:self];
    [scrollView addSubview:row];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self.studentsArray count]*CELL_HEIGHT);
    [self.studentsArray addObject:student];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end