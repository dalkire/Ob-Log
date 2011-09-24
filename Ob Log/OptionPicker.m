//
//  OptionPicker.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//
#define CELL_HEIGHT 70

#import "OptionPicker.h"

@implementation OptionPicker

@synthesize optionPickerPopover;
@synthesize arr;
@synthesize popoverHeader;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arr = [[NSMutableArray alloc] initWithCapacity:0];
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:frame];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0x04/0xFF 
                                                                           green:(float)0x81/0xFF 
                                                                            blue:(float)0xF2/0xFF 
                                                                           alpha:1].CGColor, 
                              (id)[UIColor colorWithRed:(float)0x02/0xFF 
                                                  green:(float)0x69/0xFF 
                                                   blue:(float)0xEA/0xFF 
                                                  alpha:1].CGColor, 
                              nil]];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        [[self layer] addSublayer:gradient];
    }
    return self;
}

+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSMutableArray *)options
{
    UILabel *label = [[[UILabel alloc] init] autorelease];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.text = header;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    OptionPicker *picker = [[OptionPicker alloc] initWithFrame:CGRectMake(0, 0, label.frame.size.width + 40, CELL_HEIGHT - 1)];
    label.frame = CGRectMake(20, (CELL_HEIGHT - label.frame.size.height)/2, 
                                  label.frame.size.width, 
                                  label.frame.size.height);
    label.backgroundColor = [UIColor clearColor];
    [picker addSubview:label];
    picker.arr = options;
    picker.popoverHeader = header;
    
    return picker;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{  
    NSLog(@"optionpicker touchesbegan");
    PickerOptionsViewController *content = [[PickerOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
    [content assignOptionsArray:arr withHeader:popoverHeader];
    self.optionPickerPopover = [[UIPopoverController alloc]
                                     initWithContentViewController:content];
    self.optionPickerPopover.delegate = self;
    CGPoint convertedPoint = [self convertPoint:CGPointMake(self.frame.origin.x + self.frame.size.width/2, 
                                                             self.frame.origin.y + self.frame.size.height/2) 
                                          toView:[[[self window] rootViewController] view]];

    [self.optionPickerPopover presentPopoverFromRect:CGRectMake(convertedPoint.x, 
                                                                convertedPoint.y, 
                                                                1, 
                                                                1)
                                              inView:self.superview.superview.superview.superview.superview.superview.superview
                            permittedArrowDirections:UIPopoverArrowDirectionAny 
                                            animated:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
}

@end
