//
//  EditModalViewController.m
//  Ob Log
//
//  Created by David Alkire on 9/24/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditModalViewController.h"

@implementation EditModalViewController

@synthesize navBar;
@synthesize optionsScrollWrapper;
@synthesize notesScroll;
@synthesize notes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithRed:(float)0xAA/0xFF
                                                    green:(float)0xAA/0xFF 
                                                     blue:(float)0xAA/0xFF 
                                                    alpha:1.0f];
        
        navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(
                                                                   0, 
                                                                   0, 
                                                                   540, 
                                                                   40)];
        UINavigationItem *navBarTitle = [[UINavigationItem alloc] initWithTitle:@"David Alkire - 2011-09-25 01:35:27 +0000"];
        [navBar pushNavigationItem:navBarTitle animated:NO];
        [self.view addSubview:navBar];
        
        optionsScrollWrapper = [[OptionsScrollWrapper alloc] initWithFrame:CGRectMake(
                                                                                      10, 
                                                                                      40, 
                                                                                      520, 
                                                                                      70)];
        
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"attendance" andOptions:[NSArray arrayWithObjects:@"present", @"late", @"absent", nil]]];
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"part" andOptions:[NSArray arrayWithObjects:@"participated", @"did not participate", nil]]];
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"follow up" andOptions:[NSArray arrayWithObjects:@"no follow up", @"needs follow up", nil]]];
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"attendance" andOptions:[NSArray arrayWithObjects:@"present", @"late", @"absent", nil]]];
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"participation" andOptions:[NSArray arrayWithObjects:@"participated", @"did not participate", nil]]];
        [optionsScrollWrapper.optionsScroll addOptionPicker:[OptionPicker pickerWithHeader:@"follow up" andOptions:[NSArray arrayWithObjects:@"no follow up", @"needs follow up", nil]]];
        [self.view addSubview:optionsScrollWrapper];
        
        notesScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                     optionsScrollWrapper.frame.origin.y + optionsScrollWrapper.frame.size.height, 
                                                                     540, 
                                                                     510)];
        notesScroll.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF
                                                      green:(float)0xEE/0xFF 
                                                       blue:(float)0xEE/0xFF 
                                                      alpha:1.0f];
        notes = [[UITextView alloc] initWithFrame:CGRectMake(
                                                             10, 
                                                             10, 
                                                             notesScroll.frame.size.width - 20, 
                                                             notesScroll.frame.size.height - 20)];
        notes.backgroundColor = [UIColor clearColor];
        notes.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dui erat, tristique quis iaculis sed, euismod nec urna. Morbi euismod tempor velit a pulvinar. Integer venenatis dictum nisl eget sagittis. Proin ante tellus, vehicula ut eleifend quis, condimentum et sem. Nunc felis ipsum, porttitor ac adipiscing non, lacinia ut diam. Sed sit amet pretium arcu. Ut et risus nec dolor sollicitudin rutrum ut ac urna. Curabitur laoreet est eu tortor ultricies id auctor orci molestie. Donec vehicula nunc eu arcu sagittis auctor lobortis sapien elementum. Vivamus aliquam vestibulum tellus, in condimentum leo vehicula sit amet. Sed non bibendum magna. Mauris et orci tellus, sit amet mattis purus. Curabitur ut lorem sit amet metus viverra semper.Donec convallis pellentesque semper. Phasellus justo metus, egestas sit amet porttitor eget, convallis vitae velit. Sed ac diam magna, eget blandit dui. Sed sit amet nibh urna, a rhoncus massa. Duis volutpat metus at sem fermentum in sodales lacus viverra.";
        
        notes.font = [UIFont fontWithName:@"Helvetica" size:18];
        notesScroll.contentSize = CGSizeMake(notesScroll.frame.size.width, notesScroll.frame.size.height);
        [notesScroll addSubview:notes];
        
        //notesScroll.backgroundColor = [UIColor yellowColor];
        
        [self.view addSubview:notesScroll];
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
