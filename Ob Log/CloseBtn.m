//
//  CloseBtn.m
//  Ob Log
//
//  Created by David Alkire on 11/29/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "CloseBtn.h"

@implementation CloseBtn

@synthesize delegate = _delegate;

- (id)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 19, 19)];
    if (self) {
        UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-x.png"]];
        [self addSubview:iv];
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"CLOSE");
    [_delegate didTouchCloseBtn];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
