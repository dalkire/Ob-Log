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

@synthesize managedObjectContext = _managedObjectContext;
@synthesize nextCourseId;

@synthesize delegate;
@synthesize toolbar;
@synthesize segmentedControl;
@synthesize activeSegment;
@synthesize header;
@synthesize scrollView;
@synthesize coursesArray;

@synthesize settingsPopoverController;
@synthesize settingsNavController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
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
    EditCoursesTableViewController *editCoursesViewController = [[EditCoursesTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    
    EditNavController *editNavController = [[EditNavController alloc] initWithRootViewController:editCoursesViewController];
    [editCoursesViewController.tableView reloadData];
    //[editCoursesViewController.tableView setEditing:YES];
    UIPopoverController *editPop = [[UIPopoverController alloc] initWithContentViewController:editNavController];
    
    [editPop presentPopoverFromRect:CGRectMake(618, 33, 0, 0)
                             inView:self.toolbar
           permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [editPop setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
    [editPop setDelegate:self];
    [editNavController setDelegate:self];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self loadView];
    [self initCourses];
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
    
    UIBarButtonItem *settingsBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-settings.png"] 
                                                                   style:UIBarButtonItemStyleBordered 
                                                                  target:self 
                                                                  action:@selector(didTouchSettings)];
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                               target:self 
                               action:@selector(didTouchEdit)];
    UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-add.png"] 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(addCourseModal)];
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               view.frame.size.width, 
                                                               50)];
    [self.toolbar setBarStyle:UIBarStyleDefault];
    self.toolbar.tintColor = [Theme getThemeColor];//self.navigationController.navigationBar.backgroundColor;
    [self.toolbar setItems:[NSArray arrayWithObjects:settingsBtn, flex, editBtn, segmentedButtons, nil]];
    
    self.header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                           self.toolbar.frame.origin.y + self.toolbar.frame.size.height, 
                                                           view.frame.size.width, 
                                                           80)];
    self.header.backgroundColor = [Theme getThemeColor];
    [self.header.maintitleLabel setText:@"Courses"];
    [self.header setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    self.header.maintitleLabel.textColor = [Theme getTextColorForColor:[Theme getThemeColor]];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                self.header.frame.origin.y + self.header.frame.size.height, 
                                                                view.frame.size.width, 
                                                                view.frame.size.height - 
                                                                self.toolbar.frame.size.height -
                                                                self.header.frame.size.height -
                                                                [UIApplication sharedApplication].statusBarFrame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:self.toolbar];
    [view addSubview:self.scrollView];
    [view addSubview:self.header];
    [self.toolbar setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [view setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [self setView:view];
    
    [segmentedButtons release];
    [addBtn release];
    [editBtn release];
    [flex release];
    [view release];
}

- (void)initCourses
{
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:_managedObjectContext];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"courseTitle" ascending:YES];
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
    }*/
    
    
    NSMutableArray *fetchResults = [CoreDataHelperFunctions fetchCourses];
    
    int len = [fetchResults count];
    for (int i = 0; i < len; i++) {
        [self.coursesArray addObject:(Course *)[fetchResults objectAtIndex:i]];
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:((Course *)[fetchResults objectAtIndex:i]).courseTitle];
        row.mainLabel.frame = CGRectMake(row.mainLabel.frame.origin.x + 60, 
                                         row.mainLabel.frame.origin.y, 
                                         row.mainLabel.frame.size.width - 60, 
                                         row.mainLabel.frame.size.height);
        float red   = [(NSNumber *)((Course *)[fetchResults objectAtIndex:i]).colorR floatValue]/255;
        float green = [(NSNumber *)((Course *)[fetchResults objectAtIndex:i]).colorG floatValue]/255;
        float blue  = [(NSNumber *)((Course *)[fetchResults objectAtIndex:i]).colorB floatValue]/255;
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
        [row setCourse:(Course *)[fetchResults objectAtIndex:i]];
        [row setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [scrollView addSubview:row];
        
        [colorTag release];
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
 
- (void)didTouchSettings
{
    SettingsTableViewController *settingsPopTVC = [[SettingsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [settingsPopTVC setTitle:@"Settings"];
    self.settingsNavController = [[SettingsNavigationController alloc] initWithRootViewController:settingsPopTVC];
    self.settingsPopoverController = [[UIPopoverController alloc] initWithContentViewController:settingsNavController];
    [self.settingsPopoverController presentPopoverFromRect:CGRectMake(10, 33, 0, 0) 
                                                   inView:self.toolbar
                                  permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [self.settingsPopoverController setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
    [settingsPopTVC setDelegate:self];
}

- (void)selectedOptionPickersRow
{
    NSLog(@"SELECTED OPTION PICKERS ROW");
    OptionPickersTableViewController *optionPickersTVC = [[OptionPickersTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    [optionPickersTVC setManagedObjectContext:_managedObjectContext];
    [optionPickersTVC loadOptionPickers];
    [self.settingsNavController pushViewController:optionPickersTVC animated:YES];
}

- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Touched ClickRow.course.course_title: %@", clickRow.course.courseTitle);
    [self.delegate loadDailyEditViewForCourse:clickRow.course andDate:[NSDate date]];
}

- (void)addCourseWithTitle:(NSString *)courseTitle andRed:(float)red green:(float)green blue:(float)blue
{
    Course *course = (Course *)[NSEntityDescription 
                                insertNewObjectForEntityForName:@"Course" 
                                inManagedObjectContext:_managedObjectContext];
    [course setCourseTitle:courseTitle];
    [course setColorR:[NSNumber numberWithInt:red*255]];
    [course setColorG:[NSNumber numberWithInt:green*255]];
    [course setColorB:[NSNumber numberWithInt:blue*255]];
    
    NSError *error = nil;
    if (![_managedObjectContext save:&error]) {
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
    [row setCourse:course];
    [row setDelegate:self];
    [row setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [scrollView addSubview:row];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, [self.coursesArray count]*CELL_HEIGHT);
    [self.coursesArray addObject:course];
    
    [colorTag release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _managedObjectContext = nil;
    self.delegate = nil;
    self.toolbar = nil;
    self.segmentedControl = nil;
    self.header = nil;
    self.scrollView = nil;
    self.coursesArray = nil;
}

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    NSLog(@"SHOULD AUTOROTATE");
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
    
	return NO;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    int len = [[self.scrollView subviews] count];
    for (int i = 0; i < len; i++) {
        [[[self.scrollView subviews] objectAtIndex:i] setNeedsDisplay:YES];
    }
}*/

@end