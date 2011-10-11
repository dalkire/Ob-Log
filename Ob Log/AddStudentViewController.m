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

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    NSLog(@"ADD student loadview");
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 540, 500)];
    self.header = [[Header alloc] initWithFrame:CGRectMake(0, 
                                                      0, 
                                                      540, 
                                                      80)];
    [self.header.maintitleLabel setText:@"Add Student"];
 
    self.firstNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                                            self.header.frame.size.height + 30, 
                                                                            480, 
                                                                            40)];
    self.lastNameTextField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                                           self.firstNameTextField.frame.origin.y + 
                                                                           self.firstNameTextField.frame.size.height + 10, 
                                                                           480, 
                                                                           40)];
    [self.firstNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.firstNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [self.firstNameTextField setPlaceholder:@"First name"];
 
    [self.lastNameTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.lastNameTextField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [self.lastNameTextField setPlaceholder:@"Last name"];
 
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.cancelBtn.frame = CGRectMake(self.lastNameTextField.frame.origin.x, 
                                      self.lastNameTextField.frame.origin.y + 
                                      self.lastNameTextField.frame.size.height + 30, 
                                      100, 
                                      40);
    [self.cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(touchedCancel) forControlEvents:UIControlEventTouchUpInside];
 
    self.submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.submitBtn.frame = CGRectMake(self.cancelBtn.frame.origin.x + self.cancelBtn.frame.size.width + 20, 
                                      self.cancelBtn.frame.origin.y, 
                                      100, 
                                      40);
    [self.submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitBtn addTarget:self action:@selector(touchedSubmit) forControlEvents:UIControlEventTouchUpInside];
 
 
    [view addSubview:self.firstNameTextField];
    [view addSubview:self.lastNameTextField];
    [view addSubview:self.cancelBtn];
    [view addSubview:self.submitBtn];
    [view addSubview:self.header];
    [self setView:view];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}*/

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