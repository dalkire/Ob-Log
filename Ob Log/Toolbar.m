//
//  Toolbar.m
//  Ob Log
//
//  Created by David Alkire on 10/5/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "Toolbar.h"

@implementation Toolbar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)addButtons:(NSArray *)buttons
{
    int len = [buttons count];
    for (int i = 0; i < len; i++) {
        [self addSubview:[buttons objectAtIndex:i]];
    }
}

@end
