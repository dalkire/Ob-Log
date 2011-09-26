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
