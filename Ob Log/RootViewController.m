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
#define VIEW_CONTROLLER_HISTORYEDIT 3

#import "RootViewController.h"

@implementation RootViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize currentViewController       = _currentViewController;
@synthesize coursesViewController       = _coursesViewController;
@synthesize dailyEditViewController     = _dailyEditViewController;
@synthesize courseViewController        = _courseViewController;
@synthesize historyEditViewController   = _historyEditViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        _coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
        //[self.coursesViewController loadView];
        _coursesViewController.view.frame = CGRectMake(0, 
                                                       0, 
                                                       _coursesViewController.view.frame.size.width, 
                                                       _coursesViewController.view.frame.size.height);
        [self.view addSubview:_coursesViewController.view];
        [self setCurrentViewController:VIEW_CONTROLLER_COURSES];
    }
    return self;
}

- (void)initContext
{
    [self.coursesViewController setManagedObjectContext:_managedObjectContext];
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
    _courseViewController = nil;
    if (_courseViewController == nil)
    {
        _courseViewController = [[CourseViewController alloc]
                                        initWithCourse:course];
        [_courseViewController setManagedObjectContext:_managedObjectContext];
        [_courseViewController initStudents];
        _courseViewController.view.frame = CGRectMake(0, 
                                                      0, 
                                                      _courseViewController.view.frame.size.width, 
                                                      _courseViewController.view.frame.size.height);
        [_courseViewController setDelegate:self];
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    transition = UIViewAnimationTransitionCurlUp;
    coming = _courseViewController;
    switch (_currentViewController) {
        case VIEW_CONTROLLER_COURSES:
            going = _coursesViewController;
            break;
        case VIEW_CONTROLLER_DAILYEDIT:
            going = _dailyEditViewController;
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

- (void)loadHistoryEditViewControllerForCourse:(Course *)crse
{
    _historyEditViewController = nil;
    _historyEditViewController = [[HistoryEditViewController alloc] initWithCourse:crse];
    [_historyEditViewController setManagedObjectContext:_managedObjectContext];
    //[_historyEditViewController initStudents];
    [_historyEditViewController.view setFrame:CGRectMake(0, 
                                                         0, 
                                                         _historyEditViewController.view.frame.size.width, 
                                                         _historyEditViewController.view.frame.size.height)];
    [_historyEditViewController setDelegate:self];
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    transition = UIViewAnimationTransitionCurlUp;
    coming = _historyEditViewController;
    switch (_currentViewController) {
        case VIEW_CONTROLLER_DAILYEDIT:
            going = _dailyEditViewController;
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
    [self setCurrentViewController:VIEW_CONTROLLER_HISTORYEDIT];
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
