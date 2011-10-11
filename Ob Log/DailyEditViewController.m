//
//  DailyEditViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define BG_UIIMAGEVIEW      955643
#define SHORT_CELL          776584
#define SHORT_CELL_WIDTH    300
#define NOTE_CELL           776585
#define CELL_HEIGHT         70

#define SEGMENT_STUDENTS    0
#define SEGMENT_TODAY       1
#define SEGMENT_HISTORY     2

#import "DailyEditViewController.h"

@implementation DailyEditViewController

@synthesize delegate;

@synthesize studentsMutableArray;
@synthesize entryArray;
@synthesize managedObjectContext;

@synthesize optionsPopoverController;

@synthesize toolbar;
@synthesize segmentedControl;
@synthesize bg;
@synthesize scrollView;
@synthesize dateHeader;
@synthesize dateHeaderDropShadow;
@synthesize editModal;
@synthesize activePicker;

@synthesize course;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.studentsMutableArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.entryArray = [[NSMutableArray alloc] initWithCapacity:0];
        self.course = nil;
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"didreceivememorywarning");
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"& loadView -");
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
    NSLog(@"SELF COURSE? %@", self.course == nil ? @"YES" : @"NO");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               view.frame.size.width, 
                                                               50)];
    [self.toolbar setBarStyle:UIBarStyleDefault];
    [self.toolbar setTintColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                               green:[self.course.colorG floatValue]/255 
                                                blue:[self.course.colorB floatValue]/255 
                                               alpha:1]];
    
    UIBarButtonItem *coursesBtn =[[UIBarButtonItem alloc] initWithTitle:@"Courses"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self 
                                                                 action:@selector(didTouchCoursesBtn)];
    self.segmentedControl = [[UISegmentedControl alloc] 
                        initWithItems:[NSArray arrayWithObjects:@"Students", @"Today", @"History", nil]];
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.segmentedControl setTintColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                        green:[self.course.colorG floatValue]/255 
                                                         blue:[self.course.colorB floatValue]/255 
                                                        alpha:1]];
    [self.segmentedControl setSelectedSegmentIndex:SEGMENT_TODAY];
    [self.segmentedControl addTarget:self
                              action:@selector(didTouchSegmentedControl)
                    forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *segmentedButtons = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
    
    UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                                                    target:self 
                                                    action:@selector(didTouchEditBtn)];
    UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] initWithTitle:@"Add" 
                                                              style:UIBarButtonItemStyleBordered 
                                                             target:self 
                                                             action:@selector(addCourseModal)];
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem	*fixed = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixed.width = 23;
    [self.toolbar setItems:[NSArray arrayWithObjects:coursesBtn, segmentedButtons, flex, editBtn, addBtn, nil]];
    
    self.dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 
                                                                   self.toolbar.frame.origin.y + self.toolbar.frame.size.height, 
                                                                   view.frame.size.width, 
                                                                   90)];
    [self.dateHeader setBackgroundColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                        green:[self.course.colorG floatValue]/255 
                                                         blue:[self.course.colorB floatValue]/255 
                                                        alpha:1]];
    self.dateHeader.dateTitle.textColor = self.dateHeader.sectionSubtitle.textColor = [Theme getTextColorForColor:dateHeader.backgroundColor];
    [self.dateHeader.dateTitle setText:[NSString stringWithFormat:@"%@", [NSDate date]]];
    [self.dateHeader.sectionSubtitle setText:course.courseTitle];
    self.dateHeaderDropShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                    dateHeader.frame.origin.y + dateHeader.frame.size.height, 
                                                                    view.frame.size.width, 
                                                                    8)];
    [self.dateHeaderDropShadow setBackgroundColor:[UIColor clearColor]];
    [self.dateHeader setDelegate:self];
    
    CAGradientLayer *headerDrop = [CAGradientLayer layer];
    headerDrop.frame = CGRectMake(0, 
                                  0, 
                                  dateHeaderDropShadow.frame.size.width, 
                                  dateHeaderDropShadow.frame.size.height);
    [headerDrop setColors:[NSArray arrayWithObjects: (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                         green:(float)0x33/0xFF 
                                                                          blue:(float)0x33/0xFF 
                                                                         alpha:0.4f].CGColor, 
                           (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                               green:(float)0x33/0xFF 
                                                blue:(float)0x33/0xFF 
                                               alpha:0.0f].CGColor, 
                           nil]];
    headerDrop.startPoint = CGPointMake(0, 0);
    headerDrop.endPoint = CGPointMake(0, 1);
    [[self.dateHeaderDropShadow layer] addSublayer:headerDrop];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  
                                                                self.dateHeader.frame.origin.y + self.dateHeader.frame.size.height, 
                                                                view.frame.size.width, 
                                                                view.frame.size.height - 
                                                                self.dateHeader.frame.size.height - self.toolbar.frame.size.height)];
    scrollView.contentSize = CGSizeMake(view.frame.size.width, 0);
    scrollView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:self.toolbar];
    [view addSubview:self.scrollView];
    [view addSubview:self.dateHeader];
    [view addSubview:self.dateHeaderDropShadow];
    [self setView:view];
    [view release];
}

- (void)loadStudentsForCourse:(Course *)crse andDate:(NSDate *)date
{
    NSLog(@"load students for course: %@", crse);
    [self setCourse:crse];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%@ IN courses", self.course];
    NSSortDescriptor *sortDescriptor1 = [[NSSortDescriptor alloc]
                                         initWithKey:@"lastName" ascending:YES];
    NSSortDescriptor *sortDescriptor2 = [[NSSortDescriptor alloc]
                                         initWithKey:@"firstName" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor1, sortDescriptor2, nil]];
    [sortDescriptor1 release];
    [sortDescriptor2 release];
    [request setEntity:entity];
    [entity release];
    [request setPredicate:predicate];
    [predicate release];
    
    [self.toolbar setTintColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                               green:[self.course.colorG floatValue]/255 
                                                blue:[self.course.colorB floatValue]/255 
                                               alpha:1]];
    [self.dateHeader setBackgroundColor:[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                        green:[self.course.colorG floatValue]/255 
                                                         blue:[self.course.colorB floatValue]/255 
                                                        alpha:1]];
    [self.dateHeader.sectionSubtitle setText:self.course.courseTitle];
    
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    if (managedObjectContext == nil) {
        NSLog(@"NO CONTEXT");
    }
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];*/
    
    NSError *error = nil;
    NSMutableArray *studentPointers = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (studentPointers == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success");
        self.studentsMutableArray = studentPointers;
    }
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                      @"Melissa Alkire",
                      @"David Alkire",
                      @"Bryan Catarra",
                      @"Jessie Lloyd",
                      @"Metta World Peace",
                      @"J.R. Martinez",
                      @"Tom Bergeron",
                      @"Howard Stern",
                      @"Robin Quivers",
                      @"Gary Dell'Abate",
                      @"Fred Norris",
                      @"George Takei",
                      @"Richard Christy & Sal Governale",
                      @"Sal Governale",
                      @"Oprah Winfrey",
                      @"Steve Jobs",
                      @"Steve Wozniak",
                      @"Jessie Lloyd",
                      @"Metta World Peace",
                      @"J.R. Martinez",
                      @"Tom Bergeron",
                      @"Howard Stern",
                      @"Robin Quivers",
                      @"Gary Dell'Abate",
                      nil];
	
    int len = [self.studentsMutableArray count];
    for (int i = 0; i < len; i++) {
        DailyEditRow *row = [[DailyEditRow alloc] initWithFrame:CGRectMake(0, 
                                                                           i*CELL_HEIGHT, 
                                                                           self.view.frame.size.width, 
                                                                           CELL_HEIGHT)];
        [row setTag:i];
        [row setDelegate:self];
        [row createNameCellWithName:[NSString stringWithFormat:@"%@ %@", 
                                     ((Student *)[studentsMutableArray objectAtIndex:i]).firstName, 
                                     ((Student *)[studentsMutableArray objectAtIndex:i]).lastName]];
        
        int length = [row.optionPickers count];
        for (int j = 0; j < length; j++) {
            [(OptionPicker *)[row.optionPickers objectAtIndex:j] setDelegate:self];
        }
        
        [row setNeedsDisplay];
        [self.scrollView addSubview:row];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height + CELL_HEIGHT)];
    }
}

- (void)didTouchCoursesBtn
{
    [self.delegate loadCoursesViewController];
}

- (void)didTouchSegmentedControl
{
    switch ([self.segmentedControl selectedSegmentIndex]) {
        case SEGMENT_STUDENTS:
            NSLog(@"touched segment list");
            [delegate loadCourseViewControllerForCourse:self.course];
            break;
        case SEGMENT_TODAY:
            NSLog(@"touched segment today");
            break;
        case SEGMENT_HISTORY:
            NSLog(@"touched segment history");
            break;
        default:
            break;
    }
}

- (void)didSelectOptionPicker:(OptionPicker *)picker
{
    [picker selectPicker];
    if (self.activePicker) {
        [self.activePicker deselectPicker];
    }
    self.activePicker = picker;
    
    NSLog(@"didSelectOptionPicker: %@", picker.headerLabel.text);
    OptionsPopoverTableViewController *optionsPopTVC = [[OptionsPopoverTableViewController alloc] initWithStyle:UITableViewStylePlain];
    [optionsPopTVC setOptionsArray:picker.options];
    self.optionsPopoverController = [[UIPopoverController alloc] initWithContentViewController:optionsPopTVC];
    [self.optionsPopoverController setPopoverContentSize:CGSizeMake(200, 300) 
                                                animated:YES];
    [self.optionsPopoverController presentPopoverFromRect:[picker bounds] 
                                                   inView:picker
                                 permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    [optionsPopTVC setDelegate:self];
}

- (void)didSelectOptionRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@", indexPath);
    [self.optionsPopoverController dismissPopoverAnimated:YES];
    activePicker.headerLabel.text = [activePicker.options objectAtIndex:[indexPath indexAtPosition:1]];
}

- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date
{
    NSLog(@"%d // %@", uid, date);
    self.editModal = [[EditModalViewController alloc] initWithNibName:nil bundle:nil];
    self.editModal.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:editModal animated:YES];
}

- (void)showOptionsForPicker:(OptionPicker *)picker
{
    /*[self collapseActiveRow];
     activeRow = (DailyEditRow *)((Container *)[scrollView viewWithTag:picker.rowId + 9000]).mainRow;
     
     activeRow.activePicker = picker;
     
     //[activeRow addSelectionTableForOptions:picker.options];
     
     [UIView animateWithDuration:0.5 animations:^{
     if (expandedContainer) {
     //[UIView animateWithDuration:0.3 animations:^{
     expandedContainer.frame =  CGRectMake(expandedContainer.frame.origin.x, 
     expandedContainer.frame.origin.y - activeRow.selectionTable.frame.size.height + 1, 
     expandedContainer.frame.size.width, 
     expandedContainer.frame.size.height);
     //}];
     expandedContainer = nil;
     NSLog(@"tried to collapse container activeRow.selectionTable.frame.size.height=%f", activeRow.selectionTable.frame.size.height);
     }
     expandedContainer = (Container *)[scrollView viewWithTag:picker.rowId + 9000 + 1];
     expandedContainer.frame =  CGRectMake(expandedContainer.frame.origin.x, 
     expandedContainer.frame.origin.y + activeRow.selectionTable.frame.size.height - 1, 
     expandedContainer.frame.size.width, 
     expandedContainer.frame.size.height);
     }];*/
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
