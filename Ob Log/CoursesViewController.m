//
//  CoursesViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define SEGMENT_LIST    0
#define SEGMENT_TODAY   1
#define SEGMENT_HISTORY 2

#import "CoursesViewController.h"

@implementation CoursesViewController

@synthesize managedObjectContext;
@synthesize nextCourseId;

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
        self.view.backgroundColor = [UIColor orangeColor];
        toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 
                                                              0, 
                                                              self.view.frame.size.width, 
                                                              50)];
        [toolbar setBarStyle:UIBarStyleDefault];
        toolbar.tintColor = [Theme getThemeColor];//self.navigationController.navigationBar.backgroundColor;
        
        segmentedControl = [[UISegmentedControl alloc] 
                            initWithItems:[NSArray arrayWithObjects:@"List", @"Today", @"History", nil]];
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
                                   action:@selector(flipMe)];
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
        fixed.width = 78;
        [toolbar setItems:[NSArray arrayWithObjects:segmentedButtons, flex, titleBtn, fixed, flex, editBtn, addBtn, nil]];
        [self.view addSubview:self.toolbar];
        
        self.coursesArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)didTouchSegmentedControl
{
    NSLog(@"touched seg control");
    switch ([self.segmentedControl selectedSegmentIndex]) {
        case SEGMENT_LIST:
            if (SEGMENT_LIST != activeSegment) {
                NSLog(@"touched segment list");
                [self setActiveSegment:SEGMENT_LIST];
                [segmentedControl setSelectedSegmentIndex:SEGMENT_LIST];
            }
            break;
        case SEGMENT_TODAY:
            if (SEGMENT_TODAY != activeSegment) {
                NSLog(@"touched segment today");
                [self setActiveSegment:SEGMENT_TODAY];
                [segmentedControl setSelectedSegmentIndex:SEGMENT_TODAY];
            }
        case SEGMENT_HISTORY:
            if (SEGMENT_HISTORY != activeSegment) {
                NSLog(@"touched segment history");
                [self setActiveSegment:SEGMENT_HISTORY];
                [segmentedControl setSelectedSegmentIndex:SEGMENT_HISTORY];
            }
            
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
    /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    else {
        NSLog(@"fetchResults Success..");
    }*/
    
    self.nextCourseId = 0;
    /*int len = [mutableFetchResults count];
    for (int i = 0; i < len; i++) {
        if ((NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id > self.nextCourseId) {
            self.nextCourseId = (NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id;
        }
        NSLog(@"%@", ((Course *)[mutableFetchResults objectAtIndex:i]).name);
        [self.coursesArray addObject:(Course *)[mutableFetchResults objectAtIndex:i]];
    }*/
    self.nextCourseId++;
    
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      70, 
                                                      self.view.frame.size.width, 
                                                      80)];
    [header setMaintitleLabelText:@"Courses"];
    header.maintitleLabel.textColor = [Theme getTextColorForColor:header.backgroundColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                self.toolbar.frame.size.height, 
                                                                self.view.frame.size.width, 
                                                                self.view.frame.size.height - 
                                                                self.toolbar.frame.size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    
    /*for (int i = 0; i < len; i++) {
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:((Course *)[mutableFetchResults objectAtIndex:i]).name];
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
        [scrollView addSubview:row];
        NSLog(@"RGB: %@, %@, %@",   ((Course *)[mutableFetchResults objectAtIndex:i]).colorR,
              ((Course *)[mutableFetchResults objectAtIndex:i]).colorG,
              ((Course *)[mutableFetchResults objectAtIndex:i]).colorB);
    }*/
    
    //scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
    
//    [self.view addSubview:scrollView];
    //[self.view addSubview:header];
    [self.view addSubview:toolbar];
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
    NSLog(@"Touched ClickRow: %@", clickRow);
}

- (void)addCourseModal
{
    AddClassViewController *addClassModal = [[AddClassViewController alloc] initWithNibName:nil bundle:nil];
    [addClassModal setDelegate:self];
    [addClassModal setModalPresentationStyle:UIModalPresentationFormSheet];
    [addClassModal setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self presentModalViewController:addClassModal animated:YES];
}

- (void)addCourseWithName:(NSString *)courseName andRed:(float)red green:(float)green blue:(float)blue
{
    Course *course = (Course *)[NSEntityDescription 
                                insertNewObjectForEntityForName:@"Course" 
                                inManagedObjectContext:managedObjectContext];
    [course setId:[NSNumber numberWithInt:self.nextCourseId]];
    [course setName:courseName];
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
    [row setMainLabelText:courseName];
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