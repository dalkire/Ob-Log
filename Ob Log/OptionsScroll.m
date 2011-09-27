//
//  OptionsScroll.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionsScroll.h"
#import "OptionsScrollWrapper.h"

@implementation OptionsScroll

@synthesize pickers;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        pickers = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return self;
}

- (void)addOptionPicker:(OptionPicker *)picker
{
    int len = [[self subviews] count];
    int originX = 0;
    int currNumPickers = 0;
    for (int i = 0; i < len; i++) {
        if ([[[self subviews] objectAtIndex:i] isKindOfClass:[OptionPicker class]]) {
            int tempX = ((OptionPicker *)[[self subviews] objectAtIndex:i]).frame.origin.x + ((OptionPicker *)[[self subviews] objectAtIndex:i]).frame.size.width;
            originX = tempX > originX ? tempX : originX;
            currNumPickers++;
        }
    }
    
    if (currNumPickers > 0) {
        originX += 1;
    }
    picker.frame = CGRectMake(originX, 
                              picker.frame.origin.y, 
                              picker.frame.size.width, 
                              picker.frame.size.height);
    [self addSubview:picker];
    self.contentSize = CGSizeMake(originX + picker.frame.size.width + 1, picker.frame.size.height);
    [pickers addObject:picker];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
     NSLog(@"touchesENDED in OptionsScroll");
    [super touchesEnded:touches withEvent:event];
}

/*- (void)drawRect:(CGRect)rect
{
 
}*/

@end
