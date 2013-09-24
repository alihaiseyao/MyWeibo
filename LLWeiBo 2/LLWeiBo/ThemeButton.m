//
//  ThemeButton.m
//  LLWeiBo
//
//  Created by apple  on 13-9-17.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"
#import "CONSTS.h"


@implementation ThemeButton

-(id)initWithImage:(NSString *)imageName hightLighted:(NSString *)highLightImageName
{
    self = [self init];
    if (self) {
        self.imageName = imageName;
        self.highLightImageName = highLightImageName;
    }
    return self;
}
 
-(id)initWithBackground:(NSString *)backgroundImageName
  highLightedBackground:(NSString *)backgroundHighLightImageName
{
    self = [self init];
    if (self) {
        self.backgroundImageName = backgroundImageName;
        self.backgroundHighLightImageName = backgroundHighLightImageName;
    }
    return self;
}

-(id)init{
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

//重新加载一次数据
-(void)themeNotification:(NSNotification *)notification{
    [self loadThemeImage];
}


//给每个按钮重新设置背景图片或者
-(void)loadThemeImage{
    ThemeManager *themeManager = [ThemeManager shareManager];
    
    UIImage *image = [themeManager getThemeImage:_imageName];
    UIImage *highLightImage = [themeManager getThemeImage:_highLightImageName];

    [self setImage:image forState:UIControlStateNormal];
    [self setImage:highLightImage forState:UIControlStateHighlighted];

    UIImage *backImage = [themeManager getThemeImage:_backgroundImageName];
    UIImage *backHighLightImage = [themeManager getThemeImage:_backgroundHighLightImageName];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    [self setBackgroundImage:backHighLightImage forState:UIControlStateHighlighted];
}

#pragma mark - setter
-(void)setImageName:(NSString *)imageName{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    //重新加载新的图片
    [self loadThemeImage];
}

-(void)setHighLightImageName:(NSString *)highLightImageName{
    if (_highLightImageName != highLightImageName) {
        [_highLightImageName release];
        _highLightImageName = [highLightImageName copy];
    }
    [self loadThemeImage];
}

-(void)setBackgroundImageName:(NSString *)backgroundImageName
{
    if (_backgroundImageName != backgroundImageName) {
        [_backgroundImageName release];
        _backgroundImageName = [backgroundImageName copy];
    }
    [self loadThemeImage];
}

-(void)setBackgroundHighLightImageName:(NSString *)backgroundHighLightImageName
{
    if (_backgroundHighLightImageName != backgroundHighLightImageName) {
        [_backgroundHighLightImageName release];
        _backgroundHighLightImageName = [backgroundHighLightImageName copy];
    }
    [self loadThemeImage];
}

@end
