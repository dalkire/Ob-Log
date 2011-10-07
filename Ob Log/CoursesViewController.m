//
//  CoursesViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define SEGMENT_LIST    0
#define SEGMENT_HISTORY 1

#import "CoursesViewController.h"

@implementation CoursesViewController

@synthesize managedObjectContext;
@synthesize nextCourseId;

@synthesize delegate;
@synthesize toolbar;
@synthesize segmentedControl;
@synthesize activeSegment;
@synthesize header;
@synthesize scrollView;
@synthesize coursesArray;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              self.view.frame.size.width, 
                                                              50)];
        [self.toolbar setBarStyle:UIBarStyleDefault];
        self.toolbar.tintColor = [Theme getThemeColor];//self.navigationController.navigationBar.backgroundColor;
        
        segmentedControl = [[UISegmentedControl alloc] 
                            initWithItems:[NSArray arrayWithObjects:@"List", @"History", nil]];
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
        
        NSLog(@"> %f", toolbar.frame.size.height);
        self.coursesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)didTouchSegmentedControl
{
    NSLog(@"touched seg control");
    switch ([self.segmentedControl selectedSegmentIndex]) {
        case SEGMENT_LIST:
            NSLog(@"touched segment list");
            [self setActiveSegment:SEGMENT_LIST];
            break;
        case SEGMENT_HISTORY:
            NSLog(@"touched segment history");
            [self setActiveSegment:SEGMENT_HISTORY];
            [delegate didTouchCoursesHistory];
            break;
        default:
            break;
    }
}

- (void)didTouchEdit
{
    NSLog(@"DID TOUCH EDIT");
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
    [super loadView];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                50, 
                                                                self.view.frame.size.width, 
                                                                954)];
    NSLog(@">> %f", self.toolbar.frame.size.height);
    scrollView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:scrollView];
    NSLog(@">>> %f", self.toolbar.frame.size.height);
}

- (void)initCourses
{NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success..");
    }
    
    self.nextCourseId = 0;
    int len = [mutableFetchResults count];
    for (int i = 0; i < len; i++) {
        if ((NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id > self.nextCourseId) {
            self.nextCourseId = (NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id;
        }
        
        [self.coursesArray addObject:(Course *)[mutableFetchResults objectAtIndex:i]];
    }
    self.nextCourseId++;
    
    for (int i = 0; i < len; i++) {
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:((Course *)[mutableFetchResults objectAtIndex:i]).course_title];
        row.mainLabel.frame = CGRectMake(row.mainLabel.frame.origin.x + 60, 
                                         row.mainLabel.frame.origin.y, 
                                         row.mainLabel.frame.size.width - 60, 
                                         row.mainLabel.frame.size.height);
        float red   = [(NSNumber *)((Course *)[mutableFetchResults objectAtIndex:i]).colorR floatValue]/255;
        float green = [(NSNumber *)((Course *)[mutableFetchResults objectAtIndex:i]).colorG floatValue]/255;
        float blue  = [(NSNumber *)((Course *)[mutableFetchResults objectAtIndex:i]).colorB floatValue]/255;
        ColorTag *colorTag = [[ColorTag alloc] initWithColor:[UIColor colorWithRed:red 
                                                                             green:green 
                                                                              blue:blue 
                                                                             alpha:1]];
        colorTag.frame = CGRectMake(20, 
                                    (row.frame.size.height - colorTag.frame.size.height)/2, 
                                    colorTag.frame.size.width, 
                                    colorTag.frame.size.height);
        [row addSubview:colorTag];
        [row setDelegate:self];
        [row setCourse:(Course *)[mutableFetchResults objectAtIndex:i]];
        [scrollView addSubview:row];
    }
    
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
    NSLog(@"len*CELL_HEIGHT : %d", len*CELL_HEIGHT);
}
 
/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/
 
- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Touched ClickRow.course.course_title: %@", clickRow.course.course_title);
    [self.delegate didtouchCourse:clickRow.course];
}

- (void)addCourseModal
{
    AddClassViewController *addClassModal = [[AddClassViewController alloc] initWithNibName:nil bundle:nil];
    [addClassModal setDelegate:self];
    [addClassModal setModalPresentationStyle:UIModalPresentationFormSheet];
    [addClassModal setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addClassModal animated:YES];
}

- (void)addCourseWithTitle:(NSString *)courseTitle andRed:(float)red green:(float)green blue:(float)blue
{
    Course *course = (Course *)[NSEntityDescription 
                                insertNewObjectForEntityForName:@"Course" 
                                inManagedObjectContext:managedObjectContext];
    [course setId:[NSNumber numberWithInt:self.nextCourseId]];
    [course setCourse_title:courseTitle];
    [course setColorR:[NSNumber numberWithInt:red*255]];
    [course setColorG:[NSNumber numberWithInt:green*255]];
    [course setColorB:[NSNumber numberWithInt:blue*255]];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
    ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                               [self.coursesArray count]*CELL_HEIGHT, 
                                                               self.view.frame.size.width, 
                                                               CELL_HEIGHT)];
    [row setMainLabelText:courseTitle];
    row.mainLabel.frame = CGRectMake(row.mainLabel.frame.origin.x + 60, 
                                     row.mainLabel.frame.origin.y, 
                                     row.mainLabel.frame.size.width - 60, 
                                     row.mainLabel.frame.size.height);
    ColorTag *colorTag = [[ColorTag alloc] initWithColor:[UIColor colorWithRed:red 
                                                                         green:green 
                                                                          blue:blue 
                                                                         alpha:1]];
    colorTag.frame = CGRectMake(20, 
                                (row.frame.size.height - colorTag.frame.size.height)/2, 
                                colorTag.frame.size.width, 
                                colorTag.frame.size.height);
    [row addSubview:colorTag];
    [row setDelegate:self];
    [scrollView addSubview:row];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self.coursesArray count]*CELL_HEIGHT);
    [self.coursesArray addObject:course];
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