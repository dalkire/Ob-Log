//
//  NoteCell.h
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActionsSlider.h"

@interface NoteCell : UIView
{
    ActionsSlider *actionsSlider;
    BOOL sliderIsExtended;
    UIScrollView *scrollView;
    UITextView *textView;
    NSUInteger rowId;
    NSUInteger rowPos;
}

@property (nonatomic, retain) ActionsSlider *actionsSlider;
@property BOOL sliderIsExtended;
@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UITextView *textView;
@property NSUInteger rowId;
@property NSUInteger rowPos;

- (ActionsSlider *)createActionsSlider;

@end
