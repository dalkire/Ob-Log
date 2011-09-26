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
@synthesize headerLabel;
@synthesize rowId;
@synthesize rowPos;

- (id)initWithFrame:(CGRect)frame
{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.backgroundColor = [Theme getThemeColor];
        
        CAGradientLayer *gradient = [CAGradientLayer layer];
        [gradient setFrame:frame];
        [gradient setColors:[NSArray arrayWithObjects:(id)[UIColor colorWithRed:(float)0xCC/0xFF 
                                                                           green:(float)0xCC/0xFF 
                                                                            blue:(float)0xCC/0xFF 
                                                                           alpha:0.1f].CGColor, 
                              (id)[UIColor colorWithRed:(float)0x99/0xFF 
                                                  green:(float)0x99/0xFF 
                                                   blue:(float)0x99/0xFF 
                                                  alpha:0.1f].CGColor, 
                             nil]];
        gradient.startPoint = CGPointMake(0, 0);
        gradient.endPoint = CGPointMake(0, 1);
        [[self layer] addSublayer:gradient];
        
        self.arr = [[NSMutableArray alloc] initWithCapacity:0];
        
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                10, 
                                                                frame.size.width - 40, 
                                                                frame.size.height - 20)];
        headerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        headerLabel.textColor = [UIColor whiteColor];
        [headerLabel setBackgroundColor:[UIColor clearColor]]; 
        [self addSubview:headerLabel];
    }
    
    return self;
}

- (void)setPickerHeader:(NSString *)header andOptions:(NSMutableArray *)options
{
    [headerLabel setText:header];
    [headerLabel sizeToFit];
    [headerLabel setFrame:CGRectMake(headerLabel.frame.origin.x, 
                                     (self.frame.size.height - headerLabel.frame.size.height)/2, 
                                     headerLabel.frame.size.width, 
                                     headerLabel.frame.size.height)];
    [self setFrame:CGRectMake(self.frame.origin.x, 
                              self.frame.origin.y, 
                              headerLabel.frame.size.width + 40, 
                              self.frame.size.height)];
    [self setArr:options];
}

/*+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSMutableArray *)options
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
}*/

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{  
    NSLog(@"optionpicker in rowPos %d", self.rowPos);
    int len = [[[[[self window] rootViewController] view] subviews] count];
    for (int i = 0; i < len; i++) {
        if ([[[[[[self window] rootViewController] view] subviews] objectAtIndex:i] isKindOfClass:[DailyEditRow class]]) {
            if (((DailyEditRow *)[[[[[self window] rootViewController] view] subviews] objectAtIndex:i]).rowPos > self.rowPos) {
                ((DailyEditRow *)[[[[[self window] rootViewController] view] subviews] objectAtIndex:i]).center = CGPointMake(((DailyEditRow *)[[[[[self window] rootViewController] view] subviews] objectAtIndex:i]).center.x, ((DailyEditRow *)[[[[[self window] rootViewController] view] subviews] objectAtIndex:i]).center.y + 70);
            }
        }
    }
    
    /*PickerOptionsViewController *content = [[PickerOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
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
                                            animated:YES];*/
    
    
}

- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController
{
    return YES;
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    
}

/*- (void)drawRect:(CGRect)rect
{
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace;
    size_t num_locations = 2;
    
    CGFloat locations2[2] = { 0.0, 1.0 };
    CGFloat components2[8] = {  (float)0xFF/0xFF, (float)0xFF/0xFF, (float)0xFF/0xFF, 0.2f,
        (float)0x33/0xFF, (float)0x33/0xFF, (float)0x33/0xFF, 0.2f };
    myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient = CGGradientCreateWithColorComponents(myColorspace, components2, locations2, num_locations);
    
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x = 0.0;
    myStartPoint.y = 0;
    myEndPoint.x = 0.0;
    myEndPoint.y = self.frame.size.height;
    CGContextDrawLinearGradient (UIGraphicsGetCurrentContext(), myGradient, myStartPoint, myEndPoint, 0);
    CGColorSpaceRelease(myColorspace);
    CGGradientRelease(myGradient);
}*/

@end
