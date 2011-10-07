//
//  RootViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize managedObjectContext;
@synthesize coursesViewController;
@synthesize dailyEditViewController;
@synthesize courseViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        self.coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
        //[self.coursesViewController loadView];
        self.coursesViewController.view.frame = CGRectMake(0, 
                                                           0, 
                                                           self.coursesViewController.view.frame.size.width, 
                                                           self.coursesViewController.view.frame.size.height);
        [self.view addSubview:self.coursesViewController.view];
    }
    return self;
}

- (void)initContext
{
    [self.coursesViewController setManagedObjectContext:self.managedObjectContext];
    [self.coursesViewController initCourses];
    [self.coursesViewController setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView
{
 
}*/

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

#pragma mark - delegation

- (void)didtouchCourse:(Course *)course
{
    if (self.courseViewController == nil)
    {
        NSLog(@"+before init");
        self.courseViewController = [[CourseViewController alloc]
                                        initWithCourse:course];
        NSLog(@"+after init");
        [self.courseViewController setManagedObjectContext:self.managedObjectContext];
        [self.courseViewController initStudents];
        NSLog(@"+after managed object context");
        self.courseViewController.view.frame = CGRectMake(0, 
                                                          0, 
                                                          self.courseViewController.view.frame.size.width, 
                                                          self.courseViewController.view.frame.size.height);
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    coming = courseViewController;
    going = coursesViewController;
    transition = UIViewAnimationTransitionCurlUp;
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
}

- (void)didTouchCoursesList
{
}

- (void)didTouchCoursesHistory
{
    if (self.dailyEditViewController == nil)
    {
        self.dailyEditViewController = [[DailyEditViewController alloc]
                                        initWithNibName:nil bundle:nil];
        [self.dailyEditViewController setManagedObjectContext:self.managedObjectContext];
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    coming = dailyEditViewController;
    going = coursesViewController;
    transition = UIViewAnimationTransitionCurlUp;
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
}

@end
