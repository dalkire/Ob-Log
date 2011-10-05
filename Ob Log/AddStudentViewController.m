//
//  AddStudentViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "AddStudentViewController.h"

@implementation AddStudentViewController

@synthesize delegate;
@synthesize header;
@synthesize firstNameTextField;
@synthesize lastNameTextField;
@synthesize cancelBtn;
@synthesize submitBtn;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
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
    header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      0, 
                                                      540, 
                                                      80)];
    [header setMaintitleLabelText:@"Add Student"];
    
    firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                                       header.frame.size.height + 30, 
                                                                       480, 
                                                                       40)];
    lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                                      firstNameTextField.frame.origin.y + 
                                                                      firstNameTextField.frame.size.height + 10, 
                                                                      480, 
                                                                      40)];
    [firstNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [firstNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [firstNameTextField setPlaceholder:@"First name"];
    
    [lastNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [lastNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [lastNameTextField setPlaceholder:@"Last name"];
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(lastNameTextField.frame.origin.x, 
                                 lastNameTextField.frame.origin.y + 
                                 lastNameTextField.frame.size.height + 30, 
                                 100, 
                                 40);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchedCancel) forControlEvents:UIControlEventTouchUpInside];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 20, 
                                 cancelBtn.frame.origin.y, 
                                 100, 
                                 40);
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(touchedSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:firstNameTextField];
    [self.view addSubview:lastNameTextField];
    [self.view addSubview:cancelBtn];
    [self.view addSubview:submitBtn];
    [self.view addSubview:header];
}

- (void)touchedCancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)touchedSubmit
{
    if (self.firstNameTextField.text && ![self.firstNameTextField.text isEqual:@""] && 
        self.lastNameTextField.text && ![self.lastNameTextField.text isEqual:@""]) {
        [delegate addStudentWithFirstName:self.firstNameTextField.text lastName:self.lastNameTextField.text];
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                        message:@"First and last names may not be empty" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
    [alertView show];
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