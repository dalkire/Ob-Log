//
//  NameCell.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

@synthesize nameLabel;
@synthesize rowId;
@synthesize rowPos;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 
                                                              14, 
                                                              frame.size.width - 28, 
                                                              frame.size.height - 28)];
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        [self addSubview:nameLabel];
    }
    return self;
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
