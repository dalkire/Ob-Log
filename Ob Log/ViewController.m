//
//  ViewController.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define BG_UIIMAGEVIEW 955643
#define SHORT_CELL 776584
#define SHORT_CELL_WIDTH 300
#define NOTE_CELL  776585
#define CELL_HEIGHT 70

#import "ViewController.h"

@implementation ViewController

@synthesize bg;
@synthesize scrollView;
@synthesize dateHeader;
@synthesize editModal;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    bg.tag = BG_UIIMAGEVIEW;
    bg.image = [UIImage imageNamed:@"blankwhite_vert.png"];
    if (self.view.frame.size.width < self.view.frame.size.height) {
        bg.image = [UIImage imageNamed:@"blankwhite_vert.png"];
    }
    else {
        bg.image = [UIImage imageNamed:@"blankwhite_hrzn.png"];
    }
    
    [self.view addSubview:bg];
    
    NSArray *arr = [[NSArray alloc] initWithObjects:
                    @"Melissa Alkire",
                    @"David Alkire",
                    @"Bryan Catarra",
                    @"Jessie LLoyd",
                    @"Metta World Peace",
                    @"J.R. Martinez",
                    @"Tom Bergeron",
                    @"Howard Stern",
                    @"Robin Quivers",
                    @"Gary Dell'Abate",
                    @"Fred Norris",
                    @"George Takei",
                    @"Richard Christy & Sal Governale",
                    @"Sal Governale",
                    @"Oprah Winfrey",
                    @"Steve Jobs",
                    @"Steve Wozniak",
                    @"Jessie LLoyd",
                    @"Metta World Peace",
                    @"J.R. Martinez",
                    @"Tom Bergeron",
                    @"Howard Stern",
                    @"Robin Quivers",
                    @"Gary Dell'Abate",
                    nil];
	
    int len = [arr count];
    scrollView = [[[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                84, 
                                                                self.view.frame.size.width, 
                                                                self.view.frame.size.height - 84)] autorelease];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CELL_HEIGHT*len);
    for (int i = 0; i < len; i++) {
        ShortCell *cell = [[[ShortCell alloc] initWithFrame:CGRectMake(0, i*CELL_HEIGHT, SHORT_CELL_WIDTH, CELL_HEIGHT)] autorelease];
        cell.tag = SHORT_CELL;
        cell.controller = self;
        cell.name.text = [arr objectAtIndex:i];
        
        [cell setNeedsDisplay];
        [scrollView addSubview:cell];
        
        NoteCell *noteCell = [[[NoteCell alloc] initWithFrame:CGRectMake(SHORT_CELL_WIDTH, 
                                                                        i*CELL_HEIGHT, 
                                                                        self.view.frame.size.width - SHORT_CELL_WIDTH, 
                                                                        CELL_HEIGHT)] autorelease];
        noteCell.tag = NOTE_CELL;
        
        /*UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                    5, 
                                                                    self.view.frame.size.width - SHORT_CELL_WIDTH - 40, 
                                                                    CELL_HEIGHT - 10)];
        label2.backgroundColor = [UIColor clearColor];
        label2.font = [UIFont systemFontOfSize:24];
        label2.text = [arr objectAtIndex:i];
        
        [noteCell insertSubview:label2 belowSubview:noteCell.slider];*/
        
        [noteCell setNeedsDisplay];
        [scrollView addSubview:noteCell];
    }
    [self.view addSubview:scrollView];
    
    dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    [self.view insertSubview:dateHeader atIndex:[[self.view subviews] count]];
    
    [super viewDidLoad];
}

- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date
{
    NSLog(@"%d // %@", uid, date);
    self.editModal = [[[EditModalViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    self.editModal.modalPresentationStyle = UIModalPresentationFormSheet;
    //EditEntryModalNavController *editModal = [[EditEntryModalNavController alloc] initWithRootViewController:self];
    [self presentModalViewController:editModal animated:YES];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [bg release];
    [scrollView release];
    [dateHeader release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    //self.view.hidden = YES;
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        [bg removeFromSuperview];
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 768, 1024)];
        bg.tag = BG_UIIMAGEVIEW;
        bg.image = [UIImage imageNamed:@"blankwhite_vert.png"];
        
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, 
                                      scrollView.frame.origin.y, 
                                      768, 
                                      1024 - 104);
        
        int len = [[scrollView subviews] count];
        NSLog(@"wr portrait, len=%d", len);
        for (int i = 0; i < len; i++) {
            if ([[[scrollView subviews] objectAtIndex:i] tag] == NOTE_CELL) {
                ((NoteCell *)[[scrollView subviews] objectAtIndex:i]).frame = CGRectMake(
                                                                                         SHORT_CELL_WIDTH, 
                                                                                         ((NoteCell *)[[scrollView subviews] objectAtIndex:i]).frame.origin.y,
                                                                                         768 - SHORT_CELL_WIDTH, 
                                                                                         CELL_HEIGHT);
            }
        }
        
        [dateHeader removeFromSuperview];
        dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 0, 768, 90)];
        [self.view insertSubview:dateHeader atIndex:[[self.view subviews] count]];
    }
    else {
        [bg removeFromSuperview];
        bg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        bg.tag = BG_UIIMAGEVIEW;
        bg.image = [UIImage imageNamed:@"blankwhite_hrzn.png"];
        
        scrollView.frame = CGRectMake(scrollView.frame.origin.x, 
                                      scrollView.frame.origin.y, 
                                      1024, 
                                      768 - 104);
        
        int len = [[scrollView subviews] count];
        NSLog(@"wr landscape, len=%d", len);
        for (int i = 0; i < len; i++) {
            if ([[[scrollView subviews] objectAtIndex:i] tag] == NOTE_CELL) {
                ((NoteCell *)[[scrollView subviews] objectAtIndex:i]).frame = CGRectMake(
                                                                                         SHORT_CELL_WIDTH, 
                                                                                         ((NoteCell *)[[scrollView subviews] objectAtIndex:i]).frame.origin.y,
                                                                                         1024 - SHORT_CELL_WIDTH, 
                                                                                         CELL_HEIGHT);
            }
        }
        
        [dateHeader removeFromSuperview];
        dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 0, 1024, 90)];
        [self.view insertSubview:dateHeader atIndex:[[self.view subviews] count]];
    }
    
    [self.view addSubview:bg];
    [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:bg] withSubviewAtIndex:0];
    
    
    [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:scrollView] 
                   withSubviewAtIndex:[[self.view subviews] indexOfObject:dateHeader]];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    //self.view.hidden = NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
