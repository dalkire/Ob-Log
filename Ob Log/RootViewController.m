//
//  RootViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define VIEW_CONTROLLER_COURSES     0
#define VIEW_CONTROLLER_COURSE      1
#define VIEW_CONTROLLER_DAILYEDIT   2
#define SPLASH                      77

#import "RootViewController.h"

@implementation RootViewController

@synthesize managedObjectContext;

@synthesize currentViewController;
@synthesize coursesViewController;
@synthesize dailyEditViewController;
@synthesize courseViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
        self.coursesViewController.view.frame = CGRectMake(0, 
                                                           0, 
                                                           self.coursesViewController.view.frame.size.width, 
                                                           self.coursesViewController.view.frame.size.height);
        [self setCurrentViewController:VIEW_CONTROLLER_COURSES];
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
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 768, 1004)];
    [view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    UIImageView *splash = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Default-Portrait~ipad.png"]];
    splash.frame = CGRectMake(splash.frame.origin.x, splash.frame.origin.y - 20, splash.frame.size.width, splash.frame.size.height);
    [splash setTag:SPLASH];
    
    [view addSubview:self.coursesViewController.view];
    [view addSubview:splash];
    
    self.view = view;
    [view release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"VDL");
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)timerFireMethod:(NSTimer *)theTimer
{
    NSLog(@"FIRE TIMER: %@", theTimer);
    [[self.view viewWithTag:SPLASH] removeFromSuperview];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
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
}

#pragma mark - delegation

- (void)loadCourseViewControllerForCourse:(Course *)course
{
    self.courseViewController = nil;
    if (self.courseViewController == nil)
    {
        self.courseViewController = [[CourseViewController alloc]
                                     initWithCourse:course];
        [self.courseViewController setManagedObjectContext:self.managedObjectContext];
        [self.courseViewController initStudents];
        self.courseViewController.view.frame = CGRectMake(0, 
                                                          0, 
                                                          self.courseViewController.view.frame.size.width, 
                                                          self.courseViewController.view.frame.size.height);
        [self.courseViewController setDelegate:self];
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    transition = UIViewAnimationTransitionCurlUp;
    coming = self.courseViewController;
    switch (self.currentViewController) {
        case VIEW_CONTROLLER_COURSES:
            going = self.coursesViewController;
            break;
        case VIEW_CONTROLLER_DAILYEDIT:
            going = self.dailyEditViewController;
            transition = UIViewAnimationTransitionCurlDown;
            break;
            
        default:
            break;
    }
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
    [self setCurrentViewController:VIEW_CONTROLLER_COURSE];
}

- (void)didTouchCoursesList
{
}

- (void)didTouchCoursesHistory
{
    self.dailyEditViewController = nil;
    self.dailyEditViewController = [[DailyEditViewController alloc] initWithNibName:nil bundle:nil];
    [self.dailyEditViewController setManagedObjectContext:self.managedObjectContext];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    coming = dailyEditViewController;
    switch (self.currentViewController) {
        case VIEW_CONTROLLER_COURSES:
            going = self.coursesViewController;
            break;
        case VIEW_CONTROLLER_DAILYEDIT:
            going = self.dailyEditViewController;
            break;
            
        default:
            break;
    }
    transition = UIViewAnimationTransitionCurlUp;
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
    [self setCurrentViewController:VIEW_CONTROLLER_DAILYEDIT];
}

- (void)loadCoursesViewController
{
    if (self.coursesViewController == nil)
    {
        self.coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
        [self.coursesViewController setManagedObjectContext:self.managedObjectContext];
        [self.coursesViewController setDelegate:self];
        self.coursesViewController.view.frame = CGRectMake(0, 
                                                           0, 
                                                           self.coursesViewController.view.frame.size.width, 
                                                           self.coursesViewController.view.frame.size.height);
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    coming = coursesViewController;
    switch (self.currentViewController) {
        case VIEW_CONTROLLER_COURSE:
            going = self.courseViewController;
            break;
        case VIEW_CONTROLLER_DAILYEDIT:
            going = self.dailyEditViewController;
            break;
            
        default:
            break;
    }
    transition = UIViewAnimationTransitionCurlDown;
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
    [self setCurrentViewController:VIEW_CONTROLLER_COURSES];
}

- (void)loadDailyEditViewForCourse:(Course *)course andDate:(NSDate *)date
{
    self.dailyEditViewController = nil;
    self.dailyEditViewController = [[DailyEditViewController alloc] initWithNibName:nil bundle:nil];
    self.dailyEditViewController.view.frame = CGRectMake(0, 
                                                         0, 
                                                         self.dailyEditViewController.view.frame.size.width, 
                                                         self.dailyEditViewController.view.frame.size.height);
    [self.dailyEditViewController setManagedObjectContext:self.managedObjectContext];
    [self.dailyEditViewController loadStudentsForCourse:course andDate:date];
    [self.dailyEditViewController setDelegate:self];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    coming = self.dailyEditViewController;
    switch (self.currentViewController) {
        case VIEW_CONTROLLER_COURSE:
            going = self.courseViewController;
            break;
        case VIEW_CONTROLLER_COURSES:
            going = self.coursesViewController;
            break;
            
        default:
            break;
    }
    transition = UIViewAnimationTransitionCurlUp;
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
    [self setCurrentViewController:VIEW_CONTROLLER_DAILYEDIT];
}

@end