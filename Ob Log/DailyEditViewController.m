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

#define SEGMENT_TODAY       0
#define SEGMENT_HISTORY     1

#import "DailyEditViewController.h"

@implementation DailyEditViewController

@synthesize delegate;

@synthesize studentsMutableArray;
@synthesize entriesArray;
@synthesize managedObjectContext;
@synthesize toolbar;
@synthesize segmentedControl;
@synthesize bg;
@synthesize scrollView;
@synthesize header;
@synthesize course = _course;
@synthesize date = _date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSMutableArray *sma = [[NSMutableArray alloc] initWithCapacity:0];
        self.studentsMutableArray = sma;
        [sma release];
        
        NSMutableArray *ea = [[NSMutableArray alloc] initWithCapacity:0];
        self.entriesArray = ea;
        [ea release];
        
        _course = nil;
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
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    self.toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               view.frame.size.width, 
                                                               50)];
    [self.toolbar setBarStyle:UIBarStyleDefault];
    [self.toolbar setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                               green:[self.course.colorG floatValue]/255 
                                                blue:[self.course.colorB floatValue]/255 
                                               alpha:1]];*/
    
    UIBarButtonItem *coursesBtn =[[UIBarButtonItem alloc] initWithTitle:@"Courses"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self 
                                                                 action:@selector(didTouchCoursesBtn)];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] 
                              initWithItems:[NSArray arrayWithObjects:@"Today", @"History", nil]];
    self.segmentedControl = sc;
    [sc release];
    
    self.segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [self.segmentedControl setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                        green:[self.course.colorG floatValue]/255 
                                                         blue:[self.course.colorB floatValue]/255 
                                                        alpha:1]];*/
    [self.segmentedControl setSelectedSegmentIndex:SEGMENT_TODAY];
    [self.segmentedControl addTarget:self
                              action:@selector(didTouchSegmentedControl)
                    forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *segmentedButtons = [[UIBarButtonItem alloc] initWithCustomView:self.segmentedControl];
    
    UIBarButtonItem *studentsBtn =[[UIBarButtonItem alloc] initWithTitle:@"Students"
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self 
                                                              action:@selector(didTouchStudentsBtn)];
     
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [self.toolbar setItems:[NSArray arrayWithObjects:coursesBtn, flex, studentsBtn, segmentedButtons, nil]];
    [coursesBtn release];
    [segmentedButtons release];
    [flex release];
    //[editBtn release];
    
    self.header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                           self.toolbar.frame.origin.y + self.toolbar.frame.size.height, 
                                                           view.frame.size.width, 
                                                           90)];
    UIColor *bgc = [[UIColor alloc] initWithRed:[_course.colorR floatValue]/255 
                                          green:[_course.colorG floatValue]/255 
                                           blue:[_course.colorB floatValue]/255 
                                          alpha:1];
    [self.header setBackgroundColor:bgc];
    [bgc release];
    
    self.header.maintitleLabel.textColor = self.header.subtitleLabel.textColor = [Theme getTextColorForColor:self.header.backgroundColor];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  
                                                                      self.header.frame.origin.y + self.header.frame.size.height, 
                                                                      view.frame.size.width, 
                                                                      view.frame.size.height - 
                                                                      self.toolbar.frame.size.height -
                                                                      self.header.frame.size.height -
                                                                      [UIApplication sharedApplication].statusBarFrame.size.height)];
    self.scrollView = sv;
    [sv release];
    
    self.scrollView.contentSize = CGSizeMake(view.frame.size.width, 0);
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:self.toolbar];
    [view addSubview:self.scrollView];
    [view addSubview:self.header];
    [self setView:view];
    [view release];
}

- (void)loadStudentsForCourse:(Course *)crse andDate:(NSDate *)dat
{
    _date = dat;
    _course = crse;
    
    
    [self.toolbar setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                               green:[self.course.colorG floatValue]/255 
                                                blue:[self.course.colorB floatValue]/255 
                                               alpha:1]];*/
    [self.header setBackgroundColor:[UIColor colorWithRed:[_course.colorR floatValue]/255 
                                                    green:[_course.colorG floatValue]/255 
                                                     blue:[_course.colorB floatValue]/255 
                                                    alpha:1]];
    NSLog(@"DATE: %@", _date);
    [self.header.maintitleLabel setText:[NSDateFormatter localizedStringFromDate:_date
                                                                       dateStyle:NSDateFormatterLongStyle 
                                                                       timeStyle:NSDateFormatterNoStyle]];
    [self.header.subtitleLabel setText:_course.courseTitle];
    self.header.maintitleLabel.textColor = [Theme getTextColorForColor:self.header.backgroundColor];
    self.header.subtitleLabel.textColor = [Theme getTextColorForColor:self.header.backgroundColor];
	
    [self setStudentsMutableArray:[CoreDataHelperFunctions fetchStudentsForCourse:_course]];
    int len = [self.studentsMutableArray count];
    for (int i = 0; i < len; i++) {
        NSLog(@"## student %@", (Student *)[studentsMutableArray objectAtIndex:i]);
        DailyEditRow *row = [[DailyEditRow alloc] initWithFrame:CGRectMake(0, 
                                                                           i*CELL_HEIGHT, 
                                                                           self.view.frame.size.width, 
                                                                           CELL_HEIGHT)
                                                     andStudent:(Student *)[studentsMutableArray objectAtIndex:i] 
                                                       inCourse:_course 
                                                        forDate:_date];
        [row setTag:i];
        [row setDelegate:self];
        [row setHighlightColor:self.header.backgroundColor];
        
        int length = [row.optionPickers count];
        NSLog(@"--== [row.optionPickers count]: %d", [row.optionPickers count]);
        for (int j = 0; j < length; j++) {
            [(OptionPicker *)[row.optionPickers objectAtIndex:j] setDailyEditRow:row];
            [(OptionPicker *)[row.optionPickers objectAtIndex:j] 
             setHighlightColor:[UIColor colorWithRed:[_course.colorR floatValue]/255 
                                               green:[_course.colorG floatValue]/255 
                                                blue:[_course.colorB floatValue]/255 
                                               alpha:1]];
            NSLog(@"Setting devc as delegate for OP: %@", (OptionPicker *)[row.optionPickers objectAtIndex:j]);
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

- (void)didTouchStudentsBtn
{
    EditStudentsTableViewController *editStudentsTableViewController = [[EditStudentsTableViewController alloc] 
                                                                        initWithStyle:UITableViewStyleGrouped
                                                                        andCourse:_course];
    
    EditNavController *editNavController = [[EditNavController alloc] initWithRootViewController:editStudentsTableViewController];
    UIPopoverController *editPop = [[UIPopoverController alloc] initWithContentViewController:editNavController];
    
    [editPop presentPopoverFromRect:CGRectMake(600, 50, 0, 0)
                             inView:self.toolbar
           permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [editPop setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
    [editPop setDelegate:self];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    [self loadView];
    [self loadStudentsForCourse:_course andDate:_date];
}

- (void)didTouchSegmentedControl
{
    switch ([self.segmentedControl selectedSegmentIndex]) {
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

/*- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    switch (interfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            return YES;
            break;
            
        default:
            return NO;
            break;
    }
    
	return NO;
}*/

@end
