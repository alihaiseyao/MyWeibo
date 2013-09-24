//
//  ThemeManager.h
//  LLWeiBo
//主题管理类

//  Created by apple  on 13-9-17.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ThemeManager : NSObject

@property(nonatomic,retain)NSString *themeName;
@property(nonatomic,retain)NSDictionary *themesPlist;
@property(nonatomic,retain)NSDictionary *fontColorPlist;
+ (ThemeManager *)shareManager;

//返回当前主题下,图片名对应的图片
-(UIImage *)getThemeImage:(NSString *)imageName;

-(UIColor *)getColorWithName:(NSString *)fontName;

@end
