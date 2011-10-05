//
//  NavigationController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NavigationController.h"

@implementation NavigationController

@synthesize managedObjectContext;

@synthesize homeViewController;
@synthesize classViewController;
@synthesize coursesViewController;
@synthesize dailyEditViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationBar.tintColor = [Theme getThemeColor];
        self.view.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                                    green:(float)0xEE/0xFF 
                                                     blue:(float)0xEE/0xFF 
                                                    alpha:1];
        self.toolbarHidden = NO;
        //self.navigationBarHidden = YES;
    }
    return self;
}

- (void)loadInitialViewControllers
{
    self.coursesViewController = [[CoursesViewController alloc] initWithNibName:nil bundle:nil];
    if (self.managedObjectContext) {
        self.coursesViewController.managedObjectContext = self.managedObjectContext;
        [self.coursesViewController loadView];
    }
    else {
        NSLog(@"managedObjectContext is NIL");
    }
    
    [self pushViewController:self.coursesViewController animated:YES];
    /*self.dailyEditViewController = [[DailyEditViewController alloc] initWithNibName:nil bundle:nil];
    if (self.managedObjectContext) {
        self.dailyEditViewController.managedObjectContext = self.managedObjectContext;
        [self.dailyEditViewController loadView];
    }
    else {
        NSLog(@"managedObjectContext is NIL");
    }
    [self pushViewController:self.homeViewController animated:NO];
    [self pushViewController:self.dailyEditViewController animated:NO];*/
}

- (void)didTouchDoneFromDailyEditViewController
{
    /*self.classesViewController = [[ClassesViewController alloc] 
                                  initWithNibName:nil
                                  bundle:nil];
    if (self.managedObjectContext)
        self.classesViewController.managedObjectContext = self.managedObjectContext;
    else
        NSLog(@"managedObjectContext is NIL");
    
    
    [self pushViewController:self.classesViewController animated:YES];*/
    
    self.classViewController = [[ClassViewController alloc] initWithCourse:nil];
    if (self.managedObjectContext)
        self.classViewController.managedObjectContext = self.managedObjectContext;
    else
        NSLog(@"managedObjectContext is NIL");
    
    
    [self pushViewController:self.classViewController animated:YES];
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
