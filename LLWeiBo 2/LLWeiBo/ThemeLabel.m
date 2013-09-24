//
//  ThemeLabel.m
//  LLWeiBo
//
//  Created by apple  on 13-9-21.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "ThemeLabel.h"
#import "ThemeManager.h"
@implementation ThemeLabel

-(id)init
{
    self = [super init];
    if (self) {
        //接受到消息之后
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
    [super dealloc];
}


-(id)initWithColorName:(NSString *)colorName
{
    self = [self init];
    if (self) {
        self.colorName = colorName;
    }
    return self;
}

//重写set方法
-(void)setColorName:(NSString *)colorName{
    if (_colorName != colorName) {
        [_colorName release];
        _colorName = [colorName copy];
    }
    
    [self setColor];
}

-(void)setColor
{
   UIColor *textColor = [[ThemeManager shareManager] getColorWithName:_colorName];
    self.textColor = textColor;
}


//重新加载一次数据
-(void)themeNotification:(NSNotification *)notification{
    [self setColor];
}

@end
