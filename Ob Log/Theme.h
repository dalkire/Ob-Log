//
//  Theme.h
//  Ob Log
//
//  Created by David Alkire on 9/26/11.
//  Copyright (c) 2011 Harvard Medical School. All rights reserved.
//

#define CELL_HEIGHT 70

/*#define BLUE        1
#define BLUE_R   (float)0x03/0xFF 
#define BLUE_G   (float)0x75/0xFF 
#define BLUE_B   (float)0xEE/0xFF

#define VIOLET      2
#define VIOLET_R   (float)0x4F/0xFF 
#define VIOLET_G   (float)0x42/0xFF 
#define VIOLET_B   (float)0xF8/0xFF

#define GREEN       3
#define GREEN_R   (float)0x2D/0xFF 
#define GREEN_G   (float)0xB3/0xFF 
#define GREEN_B   (float)0x87/0xFF

#define ORANGE      4
#define ORANGE_R   (float)0xFF/0xFF 
#define ORANGE_G   (float)0x99/0xFF 
#define ORANGE_B   (float)0x00/0xFF*/

#define RED         5
#define RED_R       (float)0xB2/0xFF 
#define RED_G       (float)0x22/0xFF 
#define RED_B       (float)0x22/0xFF

#define PURPLE      6
#define PURPLE_R    (float)0x99/0xFF 
#define PURPLE_G    (float)0x33/0xFF 
#define PURPLE_B    (float)0x66/0xFF

#define PINK        7
#define PINK_R      (float)0xEF/0xFF 
#define PINK_G      (float)0x59/0xFF 
#define PINK_B      (float)0x7B/0xFF

#define ORANGE      8
#define ORANGE_R    (float)0xFF/0xFF 
#define ORANGE_G    (float)0x6D/0xFF 
#define ORANGE_B    (float)0x31/0xFF

#define GREEN       9
#define GREEN_R     (float)0x73/0xFF 
#define GREEN_G     (float)0xB6/0xFF 
#define GREEN_B     (float)0x6B/0xFF

#define YELLOW      10
#define YELLOW_R    (float)0xFF/0xFF 
#define YELLOW_G    (float)0xCB/0xFF 
#define YELLOW_B    (float)0x18/0xFF

#define BLUE        11
//#define BLUE_R      (float)0x29/0xFF 
//#define BLUE_G      (float)0xA2/0xFF 
//#define BLUE_B      (float)0xC6/0xFF

#define BLUE_R      (float)0x53/0xFF 
#define BLUE_G      (float)0x85/0xFF 
#define BLUE_B      (float)0xBF/0xFF

#define COLOR       BLUE

#import <Foundation/Foundation.h>

@interface Theme : NSObject
{
    
}

+ (UIColor *)getThemeColor;
+ (UIColor *)getTextColorForColor:(UIColor *)color;

@end
