//
//  Theme.m
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#import "Theme.h"

@implementation Theme

+ (UIColor *)getThemeColor
{
    switch (COLOR) {
        case PINK:
            return [UIColor colorWithRed:PINK_R 
                                   green:PINK_G 
                                    blue:PINK_B 
                                   alpha:1];
            break;
        case BLUE:
            return [UIColor colorWithRed:BLUE_R 
                                   green:BLUE_G 
                                    blue:BLUE_B 
                                   alpha:1];
            break;
        case GREEN:
            return [UIColor colorWithRed:GREEN_R 
                                   green:GREEN_G 
                                    blue:GREEN_B
                                   alpha:1];
            break;
        case ORANGE:
            return [UIColor colorWithRed:ORANGE_R 
                                   green:ORANGE_G 
                                    blue:ORANGE_B 
                                   alpha:1];
        case RED:
            return [UIColor colorWithRed:RED_R 
                                   green:RED_G 
                                    blue:RED_B 
                                   alpha:1];
            break;
        case PURPLE:
            return [UIColor colorWithRed:PURPLE_R 
                                   green:PURPLE_G 
                                    blue:PURPLE_B 
                                   alpha:1];
            break;
        case YELLOW:
            return [UIColor colorWithRed:YELLOW_R 
                                   green:YELLOW_G 
                                    blue:YELLOW_B 
                                   alpha:1];
            break;
            
        default:
            return [UIColor colorWithRed:BLUE_R 
                                   green:BLUE_G 
                                    blue:BLUE_B 
                                   alpha:1];
            break;
    }
}

@end
