//
//  ClassesViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define CELL_HEIGHT 70

#import "ClassesViewController.h"

@implementation ClassesViewController

@synthesize managedObjectContext;
@synthesize nextCourseId;

@synthesize header;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *editBtn =[[UIBarButtonItem alloc] 
                               initWithBarButtonSystemItem:UIBarButtonSystemItemEdit 
                               target:self 
                               action:@selector(addCourseModal)];
        UIBarButtonItem *addBtn =[[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                target:self 
                               action:@selector(addCourseModal)];
        [self.navigationItem setRightBarButtonItem:addBtn];    
    }
    return self;
}

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
        NSLog(@"fetchResults Success");
    }
    
    self.nextCourseId = 0;
    int len = [mutableFetchResults count];
    for (int i = 0; i < len; i++) {
        if ((NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id > self.nextCourseId) {
            self.nextCourseId = (NSUInteger)((Course *)[mutableFetchResults objectAtIndex:i]).id;
        }
        NSLog(@"%@", ((Course *)[mutableFetchResults objectAtIndex:i]).name);
    }
    self.nextCourseId++;
    
    self.view.backgroundColor = [UIColor colorWithRed:(float)0xEE/0XFF 
                                                green:(float)0xEE/0XFF 
                                                 blue:(float)0xEE/0XFF 
                                                alpha:1];
    
    header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      0, 
                                                      self.view.frame.size.width, 
                                                      80)];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                header.frame.size.height, 
                                                                self.view.frame.size.width, 
                                                                self.view.frame.size.height - header.frame.size.height)];
    
    int min_cells = ceil((self.view.frame.size.height - header.frame.size.height)/CELL_HEIGHT);
    NSLog(@"[mutableFetchResults count] = %d", [mutableFetchResults count]);
    //len = (min_cells > len ? min_cells : len);
    for (int i = 0; i < len; i++) {
        ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                   i*CELL_HEIGHT, 
                                                                   self.view.frame.size.width, 
                                                                   CELL_HEIGHT)];
        [row setMainLabelText:((Course *)[mutableFetchResults objectAtIndex:i]).name];
        [row setDelegate:self];
        [scrollView addSubview:row];
    }
    
    NSLog(@"len : %d", len);
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
    
    [self.view addSubview:scrollView];
    [self.view addSubview:header];
}

- (void)addCourse:(NSString *)courseName
{
    Course *course = (Course *)[NSEntityDescription 
                              insertNewObjectForEntityForName:@"Course" 
                              inManagedObjectContext:managedObjectContext];
    [course setId:[NSNumber numberWithInt:self.nextCourseId]];
    [course setName:courseName];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
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