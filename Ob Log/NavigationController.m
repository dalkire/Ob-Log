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
@synthesize classesViewController;
@synthesize dailyEditViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                                    green:(float)0xEE/0xFF 
                                                     blue:(float)0xEE/0xFF 
                                                    alpha:1];
        self.homeViewController = [[HomeViewController alloc] initWithNibName:nil bundle:nil];
        
        self.dailyEditViewController = [[DailyEditViewController alloc] initWithNibName:nil bundle:nil];
        
        [self pushViewController:self.homeViewController animated:NO];
        [self pushViewController:self.dailyEditViewController animated:NO];
    }
    return self;
}

- (void)didTouchDoneFromDailyEditViewController
{
    self.classesViewController = [[ClassesViewController alloc] 
                                  initWithNibName:nil
                                  bundle:nil];
    if (self.managedObjectContext)
        self.classesViewController.managedObjectContext = self.managedObjectContext;
    else
        NSLog(@"managedObjectContext is NIL");
    
    
    [self pushViewController:self.classesViewController animated:YES];
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
