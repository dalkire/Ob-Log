//
//  Row.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "Row.h"

@implementation Row

@synthesize id;
@synthesize blueLine;
@synthesize marginLine;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:(float)0xEE/0xFF 
                                               green:(float)0xEE/0xFF 
                                                blue:(float)0xEE/0xFF 
                                               alpha:1];
        
        blueLine = [[UIView alloc] initWithFrame:CGRectMake(0, 
                                                            frame.size.height - 1, 
                                                            frame.size.width, 
                                                            1)];
        blueLine.backgroundColor = [UIColor colorWithRed:(float)0x77/0xFF 
                                                   green:(float)0x9D/0xFF 
                                                    blue:(float)0xE8/0xFF 
                                                   alpha:1];
        [blueLine setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [self addSubview:blueLine];
        
        marginLine = [[UIView alloc] initWithFrame:CGRectMake(300, 
                                                              0, 
                                                              3, 
                                                              frame.size.height)];
        marginLine.backgroundColor = [UIColor colorWithRed:(float)0xFF/0xFF 
                                                     green:(float)0xA0/0xFF 
                                                      blue:(float)0xC8/0xFF 
                                                     alpha:1.0f];
        [self addSubview:marginLine];
    }
    return self;
}

@end
