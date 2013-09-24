//
//  UIFactory.m
//  LLWeiBo
//
//  Created by apple  on 13-9-18.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "UIFactory.h"


@implementation UIFactory

+(ThemeButton *)createButton:(NSString *)imageName HighLightedName:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithImage:imageName hightLighted:highlightedName];
    return [button autorelease];
}

+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                     backgroundHighlighted:(NSString *)highlightedName
{
    ThemeButton *button = [[ThemeButton alloc] initWithBackground:backgroundImageName highLightedBackground:highlightedName];
    return [button autorelease];
}

+(ThemeImageView *)createImageView:(NSString *)imageName
{
    ThemeImageView *themeImage =  [[ThemeImageView alloc] initWithImageName:imageName];
    return [themeImage autorelease];
}

+(ThemeLabel *)createLabel:(NSString *)colorName{
    ThemeLabel *themeLabel = [[ThemeLabel alloc] initWithColorName:colorName];
    return [themeLabel autorelease];
}

@end
