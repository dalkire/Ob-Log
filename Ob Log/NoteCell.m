//
//  NoteCell.m
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

@synthesize dailyEditRow;

@synthesize actionsSlider = _actionsSlider;
@synthesize actionButton;
@synthesize optionsScrollWrapper;
@synthesize optionsScroll;
@synthesize optionPicker;

@synthesize sliderIsExtended = _sliderIsExtended;
@synthesize scrollView = _scrollView;
@synthesize textView = _textView;
@synthesize rowId = _rowId;
@synthesize rowPos = _rowPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"init note cell");
        _textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 52, 300)];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.font = [UIFont fontWithName:@"Helvetica" size:14];
        _textView.text = @"";
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 2, frame.size.width - 52, frame.size.height - 5)];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.contentSize = CGSizeMake(frame.size.width - 52, _textView.frame.size.height - 5);
        _actionsSlider = [[ActionsSlider alloc] initWithFrame:CGRectMake(-6, 
                                                                        0, 
                                                                        self.frame.size.width, 
                                                                        self.frame.size.height - 1)];
        
        [_scrollView addSubview:_textView];
        [self addSubview:_scrollView];
        [self addSubview:_actionsSlider];
        _sliderIsExtended = YES;
    }
    return self;
}

- (void)propagateDailyEditRow:(__weak id)der
{
    [self setDailyEditRow:der];
    [_actionsSlider propagateDailyEditRow:der];
}

/*- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"TOUCHES ENDED FOR NOTE CELL");
    [super touchesEnded:touches withEvent:event];
}*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
