//
//  UIFactory.h
//  LLWeiBo
//
//  Created by apple  on 13-9-18.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ThemeButton.h"
#import "ThemeImageView.h"
#import "ThemeLabel.h"
@interface UIFactory : NSObject

+(ThemeButton *)createButton:(NSString *)imageName HighLightedName:(NSString *)highlightedName;
+(ThemeButton *)createButtonWithBackground:(NSString *)backgroundImageName
                      backgroundHighlighted:(NSString *)highlightedName;

+(ThemeImageView *)createImageView:(NSString *)imageName;

+(ThemeLabel *)createLabel:(NSString *)colorName;
@end
