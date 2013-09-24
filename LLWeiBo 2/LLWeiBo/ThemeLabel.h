//
//  ThemeLabel.h
//  LLWeiBo
//
//  Created by apple  on 13-9-21.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeLabel : UILabel

@property(nonatomic,copy)NSString *colorName;

-(id)initWithColorName:(NSString *)colorName;

@end
