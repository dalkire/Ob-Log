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

@synthesize header;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIBarButtonItem *add =[[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                target:self 
                                action:@selector(addClass)];
        [add setStyle:UIBarButtonItemStyleBordered];
        [self.navigationItem setRightBarButtonItem:add];
        
        /*NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Class" inManagedObjectContext:managedObjectContext];
        [request setEntity:entity];
        
        NSError *error = nil;
        NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
        if (mutableFetchResults == nil) {
            NSLog(@"fetchResults error");
        }*/
        
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
        int len = 4;
        len = (min_cells > len ? min_cells : len);
        for (int i = 0; i < len; i++) {
            ClickRow *row = [[ClickRow alloc] initWithFrame:CGRectMake(0, 
                                                             i*CELL_HEIGHT, 
                                                             self.view.frame.size.width, 
                                                             CELL_HEIGHT)];
            [row setMainLabelText:[NSString stringWithFormat:@"American History From 1776 - 1912: %d", i]];
            [row setDelegate:self];
            [scrollView addSubview:row];
        }
        
        NSLog(@"len : %d", len);
        scrollView.contentSize = CGSizeMake(self.view.frame.size.width, len*CELL_HEIGHT);
        
        [self.view addSubview:scrollView];
        [self.view addSubview:header];
    }
    return self;
}

- (void)didTouchClickRow:(ClickRow *)clickRow
{
    NSLog(@"Touched ClickRow: %@", clickRow);
}

- (void)addClass
{
    AddClassViewController *addClassModal = [[AddClassViewController alloc] initWithNibName:nil bundle:nil];
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
