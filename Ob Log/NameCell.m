//
//  NameCell.m
//  Ob Log
//
//  Created by David Alkire on 9/25/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

@synthesize dailyEditRow;
@synthesize nameLabel;

- (id)initWithFrame:(CGRect)frame andName:(NSString *)name
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 
                                                              14, 
                                                              frame.size.width - 28, 
                                                              frame.size.height - 28)];
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:28];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = name;
        [self addSubview:nameLabel];
    }
    return self;
}

/*- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Name CELL touches ENDED");
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
