//
//  BaseNavigationController.m
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "BaseNavigationController.h"
#import "CONSTS.h"
#import "ThemeManager.h"
@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeNotification:) name:kThemeDidChangeNotification object:nil];
    }
    return self;
}

-(void)dealloc{
    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

#pragma mark - NSNotification
-(void)themeNotification:(NSNotification *)notification
{
    [self loadThemeImage];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    float version = WXHLOSVersion();
//    if (version >= 5.0) {
//        UIImage *image = [UIImage imageNamed:@"navigationbar_background.png"];
//        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    }
//    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//        [self.navigationBar setBackgroundImage:<#(UIImage *)#> forBarMetrics:<#(UIBarMetrics)#>];
//    }
    [self loadThemeImage];
}

-(void)loadThemeImage{
    
    float version = WXHLOSVersion();
    if (version >= 5.0) {
        UIImage *image = [[ThemeManager shareManager] getThemeImage:@"navigationbar_background.png"];
        [self.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }else{
        //调用setNeedsDisplay会让渲染引擎异步调用drawRect方法
        [self.navigationBar setNeedsDisplay];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
