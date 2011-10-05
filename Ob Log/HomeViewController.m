//
//  HomeViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

@synthesize header;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //[self.navigationItem setTitle:@"Home"];
        self.navigationController.navigationBar.hidden = YES;
        self.header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                               0, 
                                                               self.view.frame.size.width, 
                                                               80)];
        self.view.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
        [super viewDidLoad];
        [self.header setMaintitleLabelText:@"Home"];
        
        ClickRow *coursesRow = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                                    self.header.frame.size.height + 0, 
                                                                    self.view.frame.size.width, 
                                                                    CELL_HEIGHT)];
        [coursesRow setMainLabelText:@"Courses"];
        [self finishRow:coursesRow];
        
        [self.view addSubview:self.header];
    }
    return self;
}

- (void)finishRow:(ClickRow *)row
{
    row.marginLine.hidden = NO;
    row.mainLabel.frame = CGRectMake(row.mainLabel.frame.origin.x + 300, 
                                            row.mainLabel.frame.origin.y, 
                                            row.mainLabel.frame.size.width - 300, 
                                            row.mainLabel.frame.size.height);
    [self.view addSubview:row];
    [row setDelegate:self];
}

- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Did touch CLICK ROW");
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
