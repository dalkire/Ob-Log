//
//  EditableTableViewCell.m
//  Ob Log
//
//  Created by David Alkire on 10/20/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "EditableTableViewCell.h"

@implementation EditableTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
