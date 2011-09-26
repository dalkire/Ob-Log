//
//  DailyEditRow.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "DailyEditRow.h"

@implementation DailyEditRow

@synthesize nameCell;
@synthesize noteCell;
@synthesize optionsTable;




@synthesize tv;
@synthesize arr;
@synthesize popoverHeader;
@synthesize previousIndexPath;
@synthesize currentIndexPath;
@synthesize previousIndex;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //nameCell = [[[NameCell alloc] initWithFrame:CGRectMake(0, 
          //                                                     0, 
            //                                                   299, 
              //                                                 frame.size.height - 2)] autorelease];
        //nameCell.backgroundColor = [UIColor redColor];
         
        noteCell = [[[NoteCell alloc] initWithFrame:CGRectMake(302, 
                                                               0, 
                                                               frame.size.width - 308, 
                                                               frame.size.height)] autorelease];
         
        //[self addSubview:nameCell];
        [self addSubview:noteCell];
        
        optionsTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 
                                                                     frame.size.height - 30, 
                                                                     frame.size.width, 
                                                                     frame.size.height*2)];
        optionsTable.delegate = self;
        optionsTable.dataSource = self;
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/






- (void)assignOptionsArray:(NSMutableArray *)options withHeader:(NSString *)header
{
    arr = options;
    popoverHeader = header;
}




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if (previousIndex > -1 && indexPath.row == previousIndex) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    
    cell.textLabel.text = [arr objectAtIndex:indexPath.row];
    
    return cell;
}



#pragma mark - Table view delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return popoverHeader;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{   
    NSLog(@"%@", indexPath);
    if (previousIndex > -1) {
        [[tableView cellForRowAtIndexPath:[[indexPath indexPathByRemovingLastIndex] indexPathByAddingIndex:previousIndex]] 
         setAccessoryType:UITableViewCellAccessoryNone];
    }
    [[tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    previousIndex = [indexPath indexAtPosition:1];
    //[tableView reloadData];
}

@end