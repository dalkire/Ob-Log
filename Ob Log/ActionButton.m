//
//  ActionButton.m
//  ObLog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "ActionButton.h"
#import "NoteCell.h"
#import "NameCell.h"

@implementation ActionButton

@synthesize icon;
@synthesize name;
@synthesize isExtended;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
}

- (void)createButtonOfType:(NSString *)type
{
    if ([type isEqualToString:@"toggle"]) {
        icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 30)/2, 
                                                             (self.frame.size.height - 30)/2, 
                                                             30, 
                                                             30)];
        icon.image = [UIImage imageNamed:@"slideInBtn.png"];
        [self addSubview:icon];
        name = [[NSString alloc] initWithString:@"toggle"];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesENDED in ActionButton");
    if (((NoteCell *)self.superview.superview).sliderIsExtended) {
        [UIView animateWithDuration:0.3 animations:^{
            self.superview.frame = CGRectMake(self.superview.frame.size.width - 54, 
                                    self.superview.frame.origin.y, 
                                    self.superview.frame.size.width, 
                                    self.superview.frame.size.height);
        }];
        ((NoteCell *)self.superview.superview).sliderIsExtended = NO;
        icon.image = [UIImage imageNamed:@"slideOutBtn.png"];
    }
    else {
        [UIView animateWithDuration:0.3 animations:^{
            self.superview.frame = CGRectMake(-6, 
                                    self.superview.frame.origin.y, 
                                    self.superview.frame.size.width, 
                                    self.superview.frame.size.height);
        }];
        ((NoteCell *)self.superview.superview).sliderIsExtended = YES;
        icon.image = [UIImage imageNamed:@"slideInBtn.png"];
    }
    [super touchesEnded:touches withEvent:event];
}

@end
