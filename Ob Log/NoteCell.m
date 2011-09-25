//
//  NoteCell.m
//  oblog
//
//  Created by David Alkire on 9/21/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "NoteCell.h"

@implementation NoteCell

@synthesize slider;
@synthesize sliderIsExtended;
@synthesize scrollView;
@synthesize textView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width - 52, 300)];
        textView.backgroundColor = [UIColor clearColor];
        textView.font = [UIFont fontWithName:@"Helvetica" size:14];
        textView.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris dui erat, tristique quis iaculis sed, euismod nec urna. Morbi euismod tempor velit a pulvinar. Integer venenatis dictum nisl eget sagittis. Proin ante tellus, vehicula ut eleifend quis, condimentum et sem. Nunc felis ipsum, porttitor ac adipiscing non, lacinia ut diam. Sed sit amet pretium arcu. Ut et risus nec dolor sollicitudin rutrum ut ac urna. Curabitur laoreet est eu tortor ultricies id auctor orci molestie. Donec vehicula nunc eu arcu sagittis auctor lobortis sapien elementum. Vivamus aliquam vestibulum tellus, in condimentum leo vehicula sit amet. Sed non bibendum magna. Mauris et orci tellus, sit amet mattis purus. Curabitur ut lorem sit amet metus viverra semper.Donec convallis pellentesque semper. Phasellus justo metus, egestas sit amet porttitor eget, convallis vitae velit. Sed ac diam magna, eget blandit dui. Sed sit amet nibh urna, a rhoncus massa. Duis volutpat metus at sem fermentum in sodales lacus viverra. Aliquam at urna velit. Duis pharetra iaculis mauris at dapibus. Duis a quam eros. In viverra nibh ut dolor pharetra auctor sit amet eu metus. Pellentesque ornare sem vitae felis accumsan sit amet rutrum velit consequat. Donec feugiat lectus et lectus tempor volutpat. Sed nibh neque, sollicitudin vel rhoncus condimentum, vestibulum at massa. Fusce dapibus euismod leo, et dictum nulla scelerisque ut.Duis in porttitor sem. Morbi mauris dui, volutpat vitae rhoncus eu, ultricies a neque. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Duis et neque ut tortor tincidunt egestas at interdum nisl. Donec sagittis libero vitae metus lacinia suscipit ultricies eget diam. Nam non orci at lectus convallis eleifend et non arcu. Mauris vel elementum magna.Etiam placerat odio eget libero pretium volutpat. Quisque venenatis ligula ac lorem pretium laoreet. Praesent porta erat vel sapien mollis blandit. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus dolor elit, mattis a elementum nec, luctus vitae felis. Quisque ultrices mattis posuere. Cras eget metus nisi, eu mattis purus. In placerat nunc eu lorem varius auctor. Sed tempus lobortis orci, vitae consequat odio pharetra quis.Sed viverra nunc lacus. Aenean purus lorem, rhoncus nec fringilla eu, hendrerit vel massa. Fusce ac tellus sed eros viverra feugiat ac sit amet felis. Donec vulputate tempus posuere. Donec a ligula nulla. Aliquam erat volutpat. Pellentesque orci diam, aliquam sit amet semper at, vehicula a diam. Etiam eget odio et odio mollis pellentesque a et augue. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.";
        //[textView sizeToFit];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 2, frame.size.width - 52, frame.size.height - 5)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.contentSize = CGSizeMake(frame.size.width - 52, textView.frame.size.height - 5);
        [scrollView addSubview:textView];
        [self addSubview:scrollView];
        
        slider = [[ActionsSlider alloc] initWithFrame:CGRectMake(-6, 0, frame.size.width, frame.size.height - 1)];
        [self addSubview:slider];
        sliderIsExtended = YES;
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
