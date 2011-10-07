//
//  AddClassViewController.m
//  Ob Log
//
//  Created by David Alkire on 10/2/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "AddClassViewController.h"

@implementation AddClassViewController

@synthesize delegate;
@synthesize header;
@synthesize textField;
@synthesize colorPicker;
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
    [header setMaintitleLabelText:@"Add Course"];
    
    textField = [[UITextField alloc] initWithFrame:CGRectMake(30, 
                                                              header.frame.size.height + 30, 
                                                              480, 
                                                              40)];
    [textField setBorderStyle:UITextBorderStyleRoundedRect];
    [textField setFont:[UIFont fontWithName:@"Helvetica" size:26]];
    [textField setPlaceholder:@"Course title"];
    
    colorPicker = [[ColorPicker alloc] init];
    [colorPicker setDelegate:self];
    colorPicker.center = CGPointMake(270, 250);
    
    cancelBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(colorPicker.frame.origin.x, 
                                 colorPicker.frame.origin.y + colorPicker.frame.size.height + 10, 
                                 100, 
                                 40);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(touchedCancel) forControlEvents:UIControlEventTouchUpInside];
    
    submitBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    submitBtn.frame = CGRectMake(cancelBtn.frame.origin.x + cancelBtn.frame.size.width + 20, 
                                 colorPicker.frame.origin.y + colorPicker.frame.size.height + 10, 
                                 100, 
                                 40);
    [submitBtn setTitle:@"Submit" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(touchedSubmit) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.view addSubview:textField];
    [self.view addSubview:cancelBtn];
    [self.view addSubview:submitBtn];
    [self.view addSubview:header];
    [self.view addSubview:colorPicker];
}

- (void)touchedCancel
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)touchedSubmit
{
    if (self.textField.text && ![self.textField.text isEqual:@""]) {
        [delegate addCourseWithTitle:self.textField.text 
                             andRed:(float)colorPicker.rSlider.value/255
                              green:(float)colorPicker.gSlider.value/255 
                               blue:(float)colorPicker.bSlider.value/255];
        [self dismissModalViewControllerAnimated:YES];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                        message:@"Course title may not be empty" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)didSelectRed:(float)red green:(float)green blue:(float)blue
{
    header.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    header.maintitleLabel.textColor = [Theme getTextColorForColor:header.backgroundColor];
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
