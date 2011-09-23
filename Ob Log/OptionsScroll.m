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
    for (int i = 0; i < len; i++) {
        if ([[[self subviews] objectAtIndex:i] isKindOfClass:[OptionPicker class]]) {
            int tempX = ((OptionPicker *)[[self subviews] objectAtIndex:i]).frame.origin.x + ((OptionPicker *)[[self subviews] objectAtIndex:i]).frame.size.width;
            originX = tempX > originX ? tempX : originX;
        }
    }
    picker.frame = CGRectMake(originX + 1, 
                              picker.frame.origin.y, 
                              picker.frame.size.width, 
                              picker.frame.size.height);
    [self addSubview:picker];
    [pickers addObject:picker];
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    NSLog(@"touches should begin!!!!");
    [super touchesShouldBegin:touches withEvent:event inContentView:view];
    
    ((OptionsScrollWrapper *)self.superview).leftShadow.hidden = NO;
    ((OptionsScrollWrapper *)self.superview).rightShadow.hidden = NO;
    
    [view touchesBegan:touches withEvent:event];
    
    return YES;
}

/*- (void)drawRect:(CGRect)rect
{
 
}*/

@end
