//
//  ThemeManager.m
//  LLWeiBo
//
//  Created by apple  on 13-9-17.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "ThemeManager.h"

static ThemeManager *singleton = nil;

@implementation ThemeManager

+ (ThemeManager *)shareManager
{
    @synchronized(self)
    {
        if (singleton == nil) {
            singleton = [[super allocWithZone:NULL] init];
        }
    }
    return singleton;
}

-(id)init{
    self = [super init];
    if (self) {
        NSString *themePath = [[NSBundle mainBundle] pathForResource:@"Theme" ofType:@"plist"];
        self.themesPlist = [NSDictionary dictionaryWithContentsOfFile:themePath];
        
        //默认为空
        self.themeName = nil;
    }
    return self;
}

//切换主题时,会掉用次方法设置主题名称
-(void)setThemeName:(NSString *)themeName{
    if (_themeName != themeName) {
        [_themeName release];
        _themeName = [themeName copy];
    }
    
    NSString *themeDir = [self getThemePath];
    NSString *filePath = [themeDir stringByAppendingPathComponent:@"fontColor.plist"];
    self.fontColorPlist = [NSDictionary dictionaryWithContentsOfFile:filePath];
}

//取得主题目录
-(NSString *)getThemePath
{
    if (self.themeName == nil) {
        //如果主题名为空,则使用项目包根目录下的默认主题图片
        NSString *resuorcePath = [[NSBundle mainBundle] resourcePath];
        return resuorcePath;
    }
    
    //取得主题包路径,如:Skins/blue
    NSString *themePath = [self.themesPlist objectForKey:_themeName];
    //程序包的跟路径
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    
    //完整的主题包路径
    NSString *path = [resourcePath stringByAppendingPathComponent:themePath];
    
    return path;
}

//返回当前主题下,图片名对应图片
-(UIImage *)getThemeImage:(NSString *)imageName
{
    if (imageName.length == 0) {
        return  nil;
    }
    
    //获取主题目录
    NSString *themePath = [self getThemePath];
    NSString *imagePath = [themePath stringByAppendingPathComponent:imageName];
  
    UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
    
    return image;
}

-(UIColor *)getColorWithName:(NSString *)fontName
{
    if (fontName.length == 0) {
        return nil;
    }
    
    NSLog(@"%@",fontName);
    
    NSLog(@"%@",_fontColorPlist);
    //返回三色值,如:24,35,60
    NSString *rgb = [_fontColorPlist objectForKey:fontName];
    
    NSLog(@"%@",rgb);
    
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    NSLog(@"%@",rgbs);
    if (rgbs.count == 3) {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = Color(r, g, b, 1);
        return color;
    }
    return nil;
}

#pragma mark - singleton  setting
+(id)allocWithZone:(NSZone *)zone
{
    return [[self shareManager] retain];
}

-(id)copyWithZone:(NSZone *)zone
{
    return self;
}

-(oneway void)release
{
    //do nothing
}

-(NSUInteger)retainCount
{
    return NSUIntegerMax;
}

-(id)autorelease
{

    return self;
}


@end
