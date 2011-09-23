//
//  OptionPicker.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "OptionPicker.h"

@implementation OptionPicker

@synthesize optionPickerPopover;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
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

+ (OptionPicker *)pickerWithHeader:(NSString *)header andOptions:(NSArray *)options
{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    label.text = header;
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    OptionPicker *picker = [[OptionPicker alloc] initWithFrame:CGRectMake(0, 0, label.frame.size.width + 40, 50)];
    label.frame = CGRectMake(20, (50 - label.frame.size.height)/2, 
                                  label.frame.size.width, 
                                  label.frame.size.height);
    label.backgroundColor = [UIColor clearColor];
    [picker addSubview:label];
    return picker;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
    NSLog(@"self.superview.superview.superview.superview.superview.superview.superview=%@", self.superview.superview.superview.superview.superview.superview.superview);
    PickerOptionsViewController *content = [[PickerOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
    self.optionPickerPopover = [[UIPopoverController alloc]
                                     initWithContentViewController:content];
    self.optionPickerPopover.delegate = self;
    [self.optionPickerPopover presentPopoverFromRect:CGRectMake(
                                                                self.superview.superview.superview.superview.superview.superview.superview.frame.origin.x +
                                                                self.superview.superview.superview.superview.superview.superview.frame.origin.x +
                                                                self.superview.superview.superview.superview.superview.frame.origin.x +
                                                                self.superview.superview.superview.superview.frame.origin.x +
                                                                self.superview.superview.superview.frame.origin.x +
                                                                self.superview.superview.frame.origin.x +
                                                                self.superview.frame.origin.x +
                                                                self.frame.origin.x + self.frame.size.width/2, 
                                                                self.superview.superview.superview.superview.superview.superview.superview.frame.origin.y +
                                                                self.superview.superview.superview.superview.superview.superview.frame.origin.y +
                                                                self.superview.superview.superview.superview.superview.frame.origin.y +
                                                                self.superview.superview.superview.superview.frame.origin.y +
                                                                self.superview.superview.superview.frame.origin.y +
                                                                self.superview.superview.frame.origin.y +
                                                                self.superview.frame.origin.y +
                                                                self.frame.origin.y + self.frame.size.height/2, 
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
