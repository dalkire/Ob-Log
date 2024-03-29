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

@synthesize dailyEditRow;

@synthesize optionPickerPopover;
@synthesize options;
@synthesize optionChoicesCoreDataArray = _optionChoicesCoreDataArray;
@synthesize popoverHeader;
@synthesize headerLabel;
@synthesize rowId;
@synthesize expanded;
@synthesize gradient;
@synthesize active;
@synthesize highlightColor;

- (id)initWithFrame:(CGRect)frame andHeader:(OptionHeader *)header andOptions:(NSMutableArray *)localOptions
{
    if (self) {
        self = [super initWithFrame:frame];
        
        self.delegate = nil;
        self.dailyEditRow = nil;
        self.active = NO;
        
        self.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                               green:(float)0xDD/0xFF 
                                                blue:(float)0xDD/0xFF 
                                               alpha:1];
        
        self.highlightColor = [Theme getThemeColor];
        
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
        
        self.options = [[NSMutableArray alloc] initWithCapacity:0];
        _optionChoicesCoreDataArray = localOptions;
        
        int len = [_optionChoicesCoreDataArray count];
        int width = frame.size.width;
        for (int i = 0; i < len; i++) {
            UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                           10, 
                                                                           frame.size.width - 40, 
                                                                           frame.size.height - 20)]; 
            tempLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
            [tempLabel setText:[[_optionChoicesCoreDataArray objectAtIndex:i] choiceText]];
            [tempLabel sizeToFit];
            width = (width > tempLabel.frame.size.width) ? width : tempLabel.frame.size.width;
            [self.options addObject:[[_optionChoicesCoreDataArray objectAtIndex:i] choiceText]];
            [tempLabel release];
        }
        
        headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 
                                                                10, 
                                                                width, 
                                                                frame.size.height - 20)];
        headerLabel.font = [UIFont fontWithName:@"Helvetica" size:18];
        headerLabel.textColor = [UIColor colorWithRed:(float)0x22/0xFF 
                                                green:(float)0x22/0xFF 
                                                 blue:(float)0x22/0xFF 
                                                alpha:1];
        [headerLabel setBackgroundColor:[UIColor clearColor]];
        [headerLabel setText:[header headerText]];
        [headerLabel setTextAlignment:UITextAlignmentCenter];
        //[headerLabel sizeToFit];
        
        [self setFrame:CGRectMake(self.frame.origin.x, 
                                  self.frame.origin.y, 
                                  width + 40, 
                                  self.frame.size.height)];
        
        gradient.frame = CGRectMake(self.frame.origin.x, 
                                    self.frame.origin.y, 
                                    self.frame.size.width, 
                                    self.frame.size.height);
        //NSLog(@"pickerFRAME 2: %f", self.frame.size.width);
        
        [self addSubview:headerLabel];
        self.expanded = NO;
    }
    
    return self;
}

- (void)propagateDailyEditRow:(__weak id)der
{
    [self setDailyEditRow:der];
    [self setDelegate:der];
    [self setHighlightColor:[der highlightColor] ? [der highlightColor] : [Theme getThemeColor]];
    NSLog(@"set DER in OP: %@ %@", [der student].firstName, [der student].lastName);
}

- (void)selectPicker
{
    NSLog(@"SELECT PICKER");
    active = YES;
    self.backgroundColor = [delegate highlightColor] ? [delegate highlightColor] : [self highlightColor];
    self.headerLabel.textColor = [Theme getTextColorForColor:self.backgroundColor];
}

- (void)deselectPicker
{
    NSLog(@"DEselect picker");
    active = NO;
    self.backgroundColor = [UIColor colorWithRed:(float)0xDD/0xFF 
                                           green:(float)0xDD/0xFF 
                                            blue:(float)0xDD/0xFF 
                                           alpha:1];
    self.headerLabel.textColor = [UIColor colorWithRed:(float)0x22/0xFF 
                                                 green:(float)0x22/0xFF 
                                                  blue:(float)0x22/0xFF 
                                                 alpha:1];
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
