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
{   NSLog(@"optionpicker touches began");
    PickerOptionsViewController *content = [[PickerOptionsViewController alloc] initWithStyle:UITableViewStylePlain];
    self.optionPickerPopover = [[UIPopoverController alloc]
                                     initWithContentViewController:content];
    self.optionPickerPopover.delegate = self;
    [self.optionPickerPopover presentPopoverFromRect:CGRectMake(0, 0, 300, 500)
                                              inView:self.superview.superview
                            permittedArrowDirections:UIPopoverArrowDirectionUp 
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
