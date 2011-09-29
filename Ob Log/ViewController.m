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
@synthesize dateHeaderDropShadow;
@synthesize editModal;
@synthesize activeRow;
@synthesize expandedContainer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    activeRow = nil;
    expandedContainer = nil;
    dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    dateHeaderDropShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                    dateHeader.frame.origin.y + dateHeader.frame.size.height, 
                                                                    self.view.frame.size.width, 
                                                                    8)];
    dateHeaderDropShadow.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *headerDrop = [CAGradientLayer layer];
    headerDrop.frame = CGRectMake(
                                 0, 
                                 0, 
                                 dateHeaderDropShadow.frame.size.width, 
                                 dateHeaderDropShadow.frame.size.height);
    [headerDrop setColors:[NSArray arrayWithObjects: (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                       green:(float)0x33/0xFF 
                                                                        blue:(float)0x33/0xFF 
                                                                       alpha:0.4f].CGColor, 
                                                    (id)[UIColor colorWithRed:(float)0x33/0xFF 
                                                                        green:(float)0x33/0xFF 
                                                                         blue:(float)0x33/0xFF 
                                                                        alpha:0.0f].CGColor, 
                                                                        nil]];
    headerDrop.startPoint = CGPointMake(0, 0);
    headerDrop.endPoint = CGPointMake(0, 1);
    [[dateHeaderDropShadow layer] addSublayer:headerDrop];
    
    NSArray *array = [[NSArray alloc] initWithObjects:
                    @"Melissa Alkire",
                    @"David Alkire",
                    @"Bryan Catarra",
                    @"Jessie Lloyd",
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
                    @"Jessie Lloyd",
                    @"Metta World Peace",
                    @"J.R. Martinez",
                    @"Tom Bergeron",
                    @"Howard Stern",
                    @"Robin Quivers",
                    @"Gary Dell'Abate",
                    nil];
	
    int len = [array count];
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 
                                                                dateHeader.frame.size.height, 
                                                                self.view.frame.size.width, 
                                                                self.view.frame.size.height - dateHeader.frame.size.height)];
    scrollView.contentSize = CGSizeMake(self.view.frame.size.width, CELL_HEIGHT*len);
    
    for (int i = 0; i < len; i++) {
        Container *container = [[Container alloc] initWithFrame:CGRectMake(0, 
                                                                           i ? CELL_HEIGHT : 0, 
                                                                           self.view.frame.size.width, 
                                                                           CELL_HEIGHT*len)];
        [container setTag:9000+i];
        DailyEditRow *row = [[DailyEditRow alloc] initWithFrame:CGRectMake(0, 
                                                                           0, 
                                                                           self.view.frame.size.width, 
                                                                           CELL_HEIGHT)];
        [row propogateRowId:i andPosition:i];
        [row createNameCellWithName:[array objectAtIndex:i]];
        //row.nameCell.nameLabel.text = [array objectAtIndex:i];
        [row setNeedsDisplay];
        [container addSubview:row];
        [container setMainRow:row];
        if (i == 0) {
            [scrollView addSubview:container];
        }
        else {
            [[scrollView viewWithTag:9000 + i - 1] addSubview:container];
        }
    }
    
    [self.view addSubview:scrollView];
    
    [self.view insertSubview:dateHeader atIndex:[[self.view subviews] count]];
    [self.view addSubview:dateHeaderDropShadow];
    
    [super viewDidLoad];
}

- (void)initModalForUser:(NSUInteger)uid andDate:(NSDate *)date
{
    NSLog(@"%d // %@", uid, date);
    self.editModal = [[EditModalViewController alloc] initWithNibName:nil bundle:nil];
    self.editModal.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:editModal animated:YES];
}

- (void)showOptionsForPicker:(OptionPicker *)picker
{
    [self collapseActiveRow];
    activeRow = (DailyEditRow *)((Container *)[scrollView viewWithTag:picker.rowId + 9000]).mainRow;
    
    activeRow.activePicker = picker;
    
    [activeRow addSelectionTableForOptions:picker.options];
    
    [UIView animateWithDuration:0.5 animations:^{
        if (expandedContainer) {
          //[UIView animateWithDuration:0.3 animations:^{
                expandedContainer.frame =  CGRectMake(expandedContainer.frame.origin.x, 
                                                      expandedContainer.frame.origin.y - activeRow.selectionTable.frame.size.height + 1, 
                                                      expandedContainer.frame.size.width, 
                                                      expandedContainer.frame.size.height);
          //}];
            expandedContainer = nil;
            NSLog(@"tried to collapse container activeRow.selectionTable.frame.size.height=%f", activeRow.selectionTable.frame.size.height);
        }
        expandedContainer = (Container *)[scrollView viewWithTag:picker.rowId + 9000 + 1];
        expandedContainer.frame =  CGRectMake(expandedContainer.frame.origin.x, 
                                             expandedContainer.frame.origin.y + activeRow.selectionTable.frame.size.height - 1, 
                                             expandedContainer.frame.size.width, 
                                             expandedContainer.frame.size.height);
    }];
}

- (void)collapseActiveRow
{
    if (activeRow) {
        activeRow.activePicker.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                                                 green:(float)0xDD/0xFF 
                                                                  blue:(float)0xDD/0xFF 
                                                                 alpha:1];
        activeRow.activePicker.headerLabel.textColor = [UIColor colorWithRed:(float)0x22/0xFF 
                                                                       green:(float)0x22/0xFF 
                                                                        blue:(float)0x22/0xFF 
                                                                       alpha:1];
        [activeRow collapseRow];
    }
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
