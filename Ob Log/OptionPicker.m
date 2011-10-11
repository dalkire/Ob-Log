//
//  OptionPicker.m
//  Ob Log
//
//  Created by David Alkire on 9/22/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define CELL_HEIGHT 70

#import "OptionPicker.h"
#import "DailyEditRow.h"

@implementation OptionPicker

@synthesize delegate;

@synthesize optionPickerPopover;
@synthesize options;
@synthesize popoverHeader;
@synthesize headerLabel;
@synthesize rowId;
@synthesize rowPos;
@synthesize expanded;
@synthesize gradient;
@synthesize active;

- (id)initWithFrame:(CGRect)frame andHeader:(NSMutableString *)header andOptions:(NSMutableArray *)localOptions
{
    if (self) {
        self = [super initWithFrame:frame];
        
        delegate = nil;
        active = NO;
        
        self.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                               green:(float)0xDD/0xFF 
                                                blue:(float)0xDD/0xFF 
                                               alpha:1];
        
        gradient = [CAGradientLayer layer];
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
        //[[self layer] addSublayer:gradient];
        
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                10, 
                                                                frame.size.width - 40, 
                                                                frame.size.height - 20)];
        headerLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        headerLabel.textColor = [UIColor colorWithRed:(float)0x22/0xFF 
                                                green:(float)0x22/0xFF 
                                                 blue:(float)0x22/0xFF 
                                                alpha:1];
        [headerLabel setBackgroundColor:[UIColor clearColor]];
        [headerLabel setText:header];
        [headerLabel sizeToFit];
        /**/
        //NSLog(@"pickerFRAME 1: %f", self.frame.size.width);
        [self setFrame:CGRectMake(self.frame.origin.x, 
                                  self.frame.origin.y, 
                                  headerLabel.frame.size.width + 40, 
                                  self.frame.size.height)];
        
        [headerLabel setFrame:CGRectMake((self.frame.size.width - headerLabel.frame.size.width)/2, 
                                         (self.frame.size.height - headerLabel.frame.size.height)/2, 
                                         headerLabel.frame.size.width, 
                                         headerLabel.frame.size.height)];
        
        gradient.frame = CGRectMake(self.frame.origin.x, 
                                    self.frame.origin.y, 
                                    self.frame.size.width, 
                                    self.frame.size.height);
        //NSLog(@"pickerFRAME 2: %f", self.frame.size.width);
        
        self.options = localOptions;
        
        [self addSubview:headerLabel];
        self.expanded = NO;
    }
    
    return self;
}

- (void)selectPicker
{
    NSLog(@"SELECT PICKER");
    active = YES;
    self.backgroundColor = [Theme getThemeColor];
    self.headerLabel.textColor = [UIColor whiteColor];
}

- (void)deselectPicker
{
    NSLog(@"DEselect picker");
    active = NO;
    self.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                           green:(float)0xDD/0xFF 
                                            blue:(float)0xDD/0xFF 
                                           alpha:1];
    self.headerLabel.textColor = [UIColor blackColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"self.active=%@", self.active ? @"YES" : @"NO");
    self.active = !self.active;
    NSLog(@"touch ENDED OP, self.active=%@", self.active ? @"YES" : @"NO");
    
    if (delegate && [delegate respondsToSelector:@selector(didSelectOptionPicker:)]) {
        [self selectPicker];
        [delegate didSelectOptionPicker:self];
    }
}

@end
