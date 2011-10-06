//
//  RootViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/6/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

@synthesize coursesViewController;
@synthesize dailyEditViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
        [self.coursesViewController loadView];
        
        [self.view addSubview:self.coursesViewController.view];
    }
    return self;
}

- (void)flipMe
{
    if (self.dailyEditViewController == nil)
    {
        self.dailyEditViewController = [[DailyEditViewController alloc]
                                        initWithNibName:nil bundle:nil];
    }
    
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:1.25];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    UIViewController *coming = nil;
    UIViewController *going = nil;
    UIViewAnimationTransition transition;
    
    if (self.coursesViewController.view.superview == nil) 
    {   
        coming = coursesViewController;
        going = dailyEditViewController;
        transition = UIViewAnimationTransitionCurlUp;
    }
    else
    {
        coming = dailyEditViewController;
        going = coursesViewController;
        transition = UIViewAnimationTransitionCurlDown;
    }
    
    [UIView setAnimationTransition: transition forView:self.view cache:YES];
    [coming viewWillAppear:YES];
    [going viewWillDisappear:YES];
    [going.view removeFromSuperview];
    [self.view insertSubview: coming.view atIndex:0];
    [going viewDidDisappear:YES];
    [coming viewDidAppear:YES];
    
    [UIView commitAnimations];
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

@end
