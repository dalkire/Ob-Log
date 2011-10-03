//
//  AddClassViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "AddClassViewController.h"

@implementation AddClassViewController

@synthesize header;
@synthesize textField;
@synthesize cancelBtn;
@synthesize submitBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                          0, 
                                                          540, 
                                                          80)];
        [header setMaintitleLabelText:@"Add A Class"];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                                  header.frame.size.height + 30, 
                                                                  480, 
                                                                  40)];
        [textField setBorderStyle:UITextBorderStyleRoundedRect];
        [textField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
        [textField setPlaceholder:@"Class Name"];
        
        cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelBtn.frame = CGRectMake(30, 
                                     textField.frame.origin.y + textField.frame.size.height + 10, 
                                     100, 
                                     40);
        [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(touchedCancel) forControlEvents:UIControlEventTouchUpInside];
        
        submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        submitBtn.frame = CGRectMake(cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 20, 
                                     textField.frame.origin.y + textField.frame.size.height + 10, 
                                     100, 
                                     40);
        [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [submitBtn addTarget:self action:@selector(touchedSubmit) forControlEvents:UIControlEventTouchUpInside];
        
        
        [self.view addSubview:textField];
        [self.view addSubview:cancelBtn];
        [self.view addSubview:submitBtn];
        [self.view addSubview:header];
    }
    return self;
}

- (void)touchedCancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)touchedSubmit
{
    [self dismissModalViewControllerAnimated:YES];
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
