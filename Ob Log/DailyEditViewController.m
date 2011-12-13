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

@synthesize delegate                = _delegate;
@synthesize studentsMutableArray    = _studentsMutableArray;
@synthesize entriesArray            = _entriesArray;
@synthesize managedObjectContext    = _managedObjectContext;
@synthesize toolbar                 = _toolbar;
@synthesize segmentedControl        = _segmentedControl;
@synthesize bg                      = _bg;
@synthesize scrollView              = _scrollView;
@synthesize header                  = _header;
@synthesize course                  = _course;
@synthesize date                    = _date;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        NSMutableArray *sma = [[NSMutableArray alloc] initWithCapacity:0];
        _studentsMutableArray = sma;
        [sma release];
        
        NSMutableArray *ea = [[NSMutableArray alloc] initWithCapacity:0];
        _entriesArray = ea;
        [ea release];
        
        _course = nil;
        _date = [[NSDate alloc] init];
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
    
    _toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               view.frame.size.width, 
                                                               50)];
    [_toolbar setBarStyle:UIBarStyleDefault];
    [_toolbar setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                       green:[self.course.colorG floatValue]/255 
                                                       blue:[self.course.colorB floatValue]/255 
                                                       alpha:1]];*/
    
    UIBarButtonItem *coursesBtn =[[UIBarButtonItem alloc] initWithTitle:@"Courses"
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self 
                                                                 action:@selector(didTouchCoursesBtn)];
    
    UIBarButtonItem *homeBtn =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon-home.png"] 
                                                               style:UIBarButtonItemStyleBordered 
                                                              target:self 
                                                              action:@selector(didTouchHomeBtn)];
    
    UISegmentedControl *sc = [[UISegmentedControl alloc] 
                              initWithItems:[NSArray arrayWithObjects:@"Today", @"History", nil]];
    _segmentedControl = sc;
    //[sc release];
    
    _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [_segmentedControl setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                                green:[self.course.colorG floatValue]/255 
                                                                blue:[self.course.colorB floatValue]/255 
                                                                alpha:1]];*/
    [_segmentedControl setSelectedSegmentIndex:SEGMENT_TODAY];
    [_segmentedControl addTarget:self
                              action:@selector(didTouchSegmentedControl)
                    forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *segmentedButtons = [[UIBarButtonItem alloc] initWithCustomView:_segmentedControl];
    
    UIBarButtonItem *studentsBtn =[[UIBarButtonItem alloc] initWithTitle:@"Students"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self 
                                                                  action:@selector(didTouchStudentsBtn)];
    
    UIBarButtonItem	*flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [_toolbar setItems:[NSArray arrayWithObjects:homeBtn, flex, studentsBtn, segmentedButtons, nil]];
    [coursesBtn release];
    [segmentedButtons release];
    [flex release];
    //[editBtn release];
    
    _header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                           _toolbar.frame.origin.y + _toolbar.frame.size.height, 
                                                           view.frame.size.width, 
                                                           90)];
    UIColor *bgc = [[UIColor alloc] initWithRed:[_course.colorR floatValue]/255 
                                          green:[_course.colorG floatValue]/255 
                                           blue:[_course.colorB floatValue]/255 
                                          alpha:1];
    [_header setBackgroundColor:bgc];
    [bgc release];
    
    _header.maintitleLabel.textColor = _header.subtitleLabel.textColor = [Theme getTextColorForColor:_header.backgroundColor];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0,  
                                                                      _header.frame.origin.y + _header.frame.size.height, 
                                                                      view.frame.size.width, 
                                                                      view.frame.size.height - 
                                                                      _toolbar.frame.size.height -
                                                                      _header.frame.size.height -
                                                                      [UIApplication sharedApplication].statusBarFrame.size.height)];
    _scrollView = sv;
    _scrollView.contentSize = CGSizeMake(view.frame.size.width, 0);
    _scrollView.backgroundColor = [UIColor clearColor];
    
    [view addSubview:_toolbar];
    [view addSubview:_scrollView];
    [view addSubview:_header];
    [self setView:view];
    [view release];
}

- (void)loadStudentsForCourse:(Course *)crse andDate:(NSDate *)dat
{
    _date = dat;
    _course = crse;
    
    
    UIView *linesbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20*CELL_HEIGHT)];
    for (int i = 0; i < 20; i++) {
        Row *crBG = [[Row alloc] initWithFrame:CGRectMake(0, 
                                                          i*CELL_HEIGHT, 
                                                          self.view.frame.size.width, 
                                                          CELL_HEIGHT)];
        [crBG setUserInteractionEnabled:NO];
        [linesbg addSubview:crBG];
    }
    
    [_scrollView addSubview:linesbg];
    [linesbg release];
    
    [_toolbar setTintColor:[Theme getThemeColor]];/*[UIColor colorWithRed:[self.course.colorR floatValue]/255 
                                                       green:[self.course.colorG floatValue]/255 
                                                       blue:[self.course.colorB floatValue]/255 
                                                       alpha:1]];*/
    [_header setBackgroundColor:[UIColor colorWithRed:[_course.colorR floatValue]/255 
                                                    green:[_course.colorG floatValue]/255 
                                                     blue:[_course.colorB floatValue]/255 
                                                    alpha:1]];
    NSLog(@"Before date printout");
    NSLog(@"DATE: %@", _date);
    [_header.maintitleLabel setText:[NSDateFormatter localizedStringFromDate:_date
                                                                       dateStyle:NSDateFormatterLongStyle 
                                                                       timeStyle:NSDateFormatterNoStyle]];
    [_header.subtitleLabel setText:_course.courseTitle];
    _header.maintitleLabel.textColor = [Theme getTextColorForColor:_header.backgroundColor];
    _header.subtitleLabel.textColor = [Theme getTextColorForColor:_header.backgroundColor];
    
    _studentsMutableArray = [CoreDataHelperFunctions fetchStudentsForCourse:_course];
    int len = [_studentsMutableArray count];
    for (int i = 0; i < len; i++) {
        NSLog(@"## student %@", (Student *)[_studentsMutableArray objectAtIndex:i]);
        DailyEditRow *row = [[DailyEditRow alloc] initWithFrame:CGRectMake(0, 
                                                                           i*CELL_HEIGHT, 
                                                                           self.view.frame.size.width, 
                                                                           CELL_HEIGHT)
                                                     andStudent:(Student *)[_studentsMutableArray objectAtIndex:i] 
                                                       inCourse:_course 
                                                        forDate:_date];
        [row setTag:i];
        [row setDelegate:self];
        [row setHighlightColor:_header.backgroundColor];
        
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
        [_scrollView addSubview:row];
        [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width, _scrollView.contentSize.height + CELL_HEIGHT)];
    }
}

- (void)didTouchHomeBtn
{
    [_delegate loadCoursesViewController];
}

- (void)didTouchStudentsBtn
{
    EditStudentsTableViewController *editStudentsTableViewController = [[EditStudentsTableViewController alloc] 
                                                                        initWithStyle:UITableViewStyleGrouped
                                                                        andCourse:_course];
    
    EditNavController *editNavController = [[EditNavController alloc] initWithRootViewController:editStudentsTableViewController];
    UIPopoverController *editPop = [[UIPopoverController alloc] initWithContentViewController:editNavController];
    
    [editPop presentPopoverFromRect:CGRectMake(604, 33, 0, 0)
                             inView:_toolbar
           permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    [editPop setPopoverContentSize:CGSizeMake(320, 480) animated:NO];
    [editPop setDelegate:self];
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    //[self loadView];
    //NSLog(@"POPOVER DATE: %@", _date ? _date : @"-not found-");
    //[self loadStudentsForCourse:_course andDate:[NSDate date]];
}

- (void)didTouchSegmentedControl
{
    switch ([_segmentedControl selectedSegmentIndex]) {
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