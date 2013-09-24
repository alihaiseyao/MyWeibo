//
//  ThemeImageView.m
//  LLWeiBo
//
//  Created by apple  on 13-9-21.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"
#import "CONSTS.h"
@implementation ThemeImageView

//如果用xib创建就不会调用init初始化,而是会用这个初始化方法
-(void)awakeFromNib{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
    [super dealloc];
}

-(id)initWithImageName:(NSString *)imageName
{
    self = [self init];
    if (self) {
        self.imageName = imageName;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

//重写set方法
-(void)setImageName:(NSString *)imageName
{
    if (_imageName != imageName) {
        [_imageName release];
        _imageName = [imageName copy];
    }
    [self loadThemeImage];
}

-(void)loadThemeImage{
    //如果图片名不存在直接退出
    if (self.imageName == nil) {
        return;
    }
    
    /******大概思路******
     *当选中那个cell的时候,就发送消息,同时改变themeManager中的主题名字,这样themeManager就会重新改变取图片路径,然后button,imageView接受到消息,,就会调用单例类重新加载一次图片
     */
   UIImage *image = [[ThemeManager shareManager] getThemeImage:self.imageName];
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapHeight];
    
    self.image = image;
}

#pragma mark - NSNotification
-(void)themeNotification:(NSNotification *)notifaction
{
    [self loadThemeImage];
}

@end
