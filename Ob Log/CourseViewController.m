//
//  CourseViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define SEGMENT_LIST    0
#define SEGMENT_HISTORY 1

#import "CourseViewController.h"

@implementation CourseViewController

@synthesize managedObjectContext;

@synthesize toolbar;
@synthesize segmentedControl;
@synthesize header;
@synthesize scrollView;
@synthesize studentsArray;
@synthesize activeSegment;
@synthesize course;

- (id)initWithCourse:(Course *)crse
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setCourse:crse];
        self.studentsArray = [[NSMutableArray alloc] initWithCapacity:0];
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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    float width = 0;
    float height = 0;
    switch ([[UIDevice currentDevice] orientation]) {
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationPortraitUpsideDown:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
        case UIDeviceOrientationLandscapeLeft:
        case UIDeviceOrientationLandscapeRight:
            width = [UIScreen mainScreen].bounds.size.height;
            height = [UIScreen mainScreen].bounds.size.width;
            break;
            
        default:
            width = [UIScreen mainScreen].bounds.size.width;
            height = [UIScreen mainScreen].bounds.size.height;
            break;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.segmentedControl = [[UISegmentedControl alloc] 
                        initWithItems:[NSArray arrayWithObjects:@"Students", @"Today", @"History", nil]];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    self.segmentedControl.tintColor = [UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                      green:[self.course.colorG floatValue]/255 
                                                       blue:[self.course.colorB floatValue]/255 
                                                      alpha:1];
    [self.segmentedControl setSelectedSegmentIndex:SEGMENT_LIST];
    [self setActiveSegment:SEGMENT_LIST];
    [self.segmentedControl addTarget:self
                              action:@selector(didTouchSegmentedControl)
                    forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *segmentedButtons = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
    
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                               target:self 
                               action:@selector(didTouchEdit)];
    UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithTitle:@"Add Student" 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(addStudentModal)];  
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               view.frame.size.width, 
                                                               50)];
    [self.toolbar setBarStyle:UIBarStyleDefault];
    self.toolbar.tintColor = [UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                             green:[self.course.colorG floatValue]/255 
                                              blue:[self.course.colorB floatValue]/255 
                                             alpha:1];
    [self.toolbar setItems:[NSArray arrayWithObjects:segmentedButtons, flex, editBtn, addBtn, nil]];
    
    self.header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      self.toolbar.frame.origin.y + self.toolbar.frame.size.height, 
                                                      view.frame.size.width, 
                                                      80)];
    self.header.backgroundColor = [UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                  green:[self.course.colorG floatValue]/255 
                                                   blue:[self.course.colorB floatValue]/255 
                                                  alpha:1];
    [self.header setMaintitleLabelText:self.course.courseTitle];
    self.header.backgroundColor = [UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                  green:[self.course.colorG floatValue]/255 
                                                   blue:[self.course.colorB floatValue]/255 
                                                  alpha:1];
    self.header.maintitleLabel.textColor = [Theme getTextColorForColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                                                       green:[self.course.colorG floatValue]/255 
                                                                                        blue:[self.course.colorB floatValue]/255 
                                                                                       alpha:1]];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                     self.header.frame.origin.y + self.header.frame.size.height, 
                                                                     view.frame.size.width, 
                                                                     view.frame.size.height - (self.header.frame.origin.y + self.header.frame.size.height))];
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:self.toolbar];
    [view addSubview:self.scrollView];
    [view addSubview:self.header];
    [self setView:view];
    [view release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
/*- (void)viewDidLoad
{
    [super viewDidLoad];
}*/

- (void)loadStudentsForCourse:(Course *)course
{
    
}

- (void)initStudents
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN courses", self.course];
    [request setEntity:entity];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success HERE..`");
    }
    
    int len = [mutableFetchResults count];
    for (int i = 0; i < len; i++) {
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:[NSString stringWithFormat:@"%@ %@", 
                               ((Student *)[mutableFetchResults objectAtIndex:i]).firstName,
                               ((Student *)[mutableFetchResults objectAtIndex:i]).lastName]];
        [row setClickColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                           green:[self.course.colorG floatValue]/255 
                                            blue:[self.course.colorB floatValue]/255 
                                           alpha:1]];
        [row setDelegate:self];
        [scrollView addSubview:row];
        [self.studentsArray addObject:(Student *)[mutableFetchResults objectAtIndex:i]];
    }
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
}

- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Touched ClickRow: %@", clickRow);
    
}

- (void)addStudentModal
{
    AddStudentViewController *addStudentModal = [[AddStudentViewController alloc] initWithNibName:nil bundle:nil];
    [addStudentModal loadView];
    [addStudentModal setDelegate:self];
    addStudentModal.header.backgroundColor = [UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                             green:[self.course.colorG floatValue]/255 
                                                              blue:[self.course.colorB floatValue]/255 
                                                             alpha:1];
    addStudentModal.header.maintitleLabel.textColor = [Theme getTextColorForColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                                                                  green:[self.course.colorG floatValue]/255 
                                                                                                   blue:[self.course.colorB floatValue]/255 
                                                                                                  alpha:1]];
    [addStudentModal setModalPresentationStyle:UIModalPresentationFormSheet];
    [addStudentModal setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addStudentModal animated:YES];
}

- (void)addStudentWithFirstName:(NSString *)first lastName:(NSString *)last
{
    Student *student = (Student *)[NSEntityDescription 
                                   insertNewObjectForEntityForName:@"Student" 
                                   inManagedObjectContext:managedObjectContext];
    [student setFirstName:first];
    [student setLastName:last];
    [student addCoursesObject:self.course];
    
    
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
    ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                               [self.studentsArray count]*CELL_HEIGHT, 
                                                               self.view.frame.size.width, 
                                                               CELL_HEIGHT)];
    [row setMainLabelText:[NSString stringWithFormat:@"%@ %@", first, last]];
    [row setClickColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                       green:[self.course.colorG floatValue]/255 
                                        blue:[self.course.colorB floatValue]/255 
                                       alpha:1]];
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
