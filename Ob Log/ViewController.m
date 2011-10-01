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

#import "AppDelegate.h"
#import "ViewController.h"
#import "Item.h"

@implementation ViewController

@synthesize items;
@synthesize managedObjectContext;

@synthesize bg;
@synthesize scrollView;
@synthesize dateHeader;
@synthesize dateHeaderDropShadow;
@synthesize editModal;
@synthesize activeRow;
@synthesize activePicker;
@synthesize expandedContainer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:managedObjectContext];
    [request setEntity:entity];
    
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        NSLog(@"fetchResults error");
    }
    
    
    
    activeRow = nil;
    expandedContainer = nil;
    
    dateHeader = [[DateHeader alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 90)];
    dateHeaderDropShadow = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                                    dateHeader.frame.origin.y + dateHeader.frame.size.height, 
                                                                    self.view.frame.size.width, 
                                                                    8)];
    dateHeaderDropShadow.backgroundColor = [UIColor clearColor];
    
    [dateHeader setDelegate:self];
    
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
    
    /*NSArray *array = [[NSArray alloc] initWithObjects:
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
                    nil];*/
	
    int len = [mutableFetchResults count];
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
        [row setContainerTag:container.tag];
        [row setDelegate:self];
        //[row propogateRowId:i andPosition:i];
        [row createNameCellWithName:[[mutableFetchResults objectAtIndex:i] valueForKey:@"name"]];
        //row.nameCell.nameLabel.text = [array objectAtIndex:i];
        [row setNeedsDisplay];
        [container addSubview:row];
        container.mainRow = row;
        
        if (i == 0) {
            [scrollView addSubview:container];
        }
        else {
            [[scrollView viewWithTag:9000 + i - 1] addSubview:container];
        }
    }
    
    scrollView.backgroundColor = [UIColor colorWithRed:(float)0x99/0xFF 
                                                 green:(float)0x99/0xFF 
                                                  blue:(float)0x99/0xFF 
                                                 alpha:1];
    [self.view addSubview:scrollView];
    
    [self.view insertSubview:dateHeader atIndex:[[self.view subviews] count]];
    [self.view addSubview:dateHeaderDropShadow];
}

- (void)didTouchDateHeader
{
    NSLog(@"DID Touch Date Header");
    
    for (int i = 0; i < 25; i++) {
    Item *item = (Item *)[NSEntityDescription 
                          insertNewObjectForEntityForName:@"Item" 
                          inManagedObjectContext:managedObjectContext];
    [item setId:[NSNumber numberWithInt:i]];
    [item setName:[NSString stringWithFormat:@"Hello %d", i]];
    
    NSError *error = nil;
    if (![managedObjectContext save:&error]) {
        NSLog(@"An error occurred while attempting to save data.");
    }
    }
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
    /*[self collapseActiveRow];
    activeRow = (DailyEditRow *)((Container *)[scrollView viewWithTag:picker.rowId + 9000]).mainRow;
    
    activeRow.activePicker = picker;
    
    //[activeRow addSelectionTableForOptions:picker.options];
    
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
    }];*/
}

- (void)didAddSelectionTableToRow:(DailyEditRow *)row
{
    NSLog(@"didAddSelectionTableToRow");
    if (expandedContainer) {
        [self collapseContainer:expandedContainer];
    }
    
    self.activeRow = row;
    [self expandContainer:(Container *)[scrollView viewWithTag:self.activeRow.containerTag + 1]];
}

- (void)didRemoveSelectionTableFromRow:(DailyEditRow *)row
{
    NSLog(@"did remove selectiontablefromrow");
    [self collapseContainer:(Container *)[scrollView viewWithTag:row.containerTag + 1]];
}

- (void)expandContainer:(Container *)container
{
    NSLog(@"2)container.mainRow.selectionTable %@", container.mainRow.selectionTable);
    
    NSLog(@"expandContainer: %f", container.mainRow.selectionTable.frame.size.height);
    [UIView animateWithDuration:0.4 animations:^{
        expandedContainer = container;
        container.frame =  CGRectMake(container.frame.origin.x, 
                                      container.frame.origin.y + self.activeRow.selectionTable.frame.size.height, 
                                      container.frame.size.width, 
                                      container.frame.size.height);
    }];
}

- (void)collapseContainer:(Container *)container
{
    NSLog(@"activeRow.containerTag=%d & activeRow.selectionTable=%@", activeRow.containerTag, activeRow.selectionTable);
    [UIView animateWithDuration:0.1 animations:^{
        container.frame =  CGRectMake(container.frame.origin.x, 
                                      container.frame.origin.y - self.activeRow.selectionTable.frame.size.height, 
                                      container.frame.size.width, 
                                      container.frame.size.height);
    }];
    expandedContainer = nil;
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
