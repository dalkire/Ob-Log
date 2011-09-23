//
//  NoteCell.h
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cell.h"
#import "ActionsSlider.h"

@interface NoteCell : Cell
{
    ActionsSlider *slider;
    BOOL sliderIsExtended;
    UIScrollView *scrollView;
    UITextView *textView;
}

@property (nonatomic, retain) ActionsSlider *slider;
@property BOOL sliderIsExtended;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITextView *textView;

@end
