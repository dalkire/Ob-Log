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
    [self addSubview:picker];
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
