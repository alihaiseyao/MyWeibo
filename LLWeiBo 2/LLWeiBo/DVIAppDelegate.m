//
//  DVIAppDelegate.m
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "DVIAppDelegate.h"
#import "MainViewController.h"
#import "DDMenuController.h"
#import "LeftViewController.h"
#import "RightViewController.h"
#import "SinaWeibo.h"
#import "CONSTS.h"
#import "ThemeManager.h"
@implementation DVIAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

-(void)_initSinaWeibo{
    
    _sinaWeiBo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:_mainController];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        _sinaWeiBo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        _sinaWeiBo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        _sinaWeiBo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }
}

//将保存到本地的数据去出来,设置主题
-(void)setThemeName
{
    NSString *themeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
    [[ThemeManager shareManager] setThemeName:themeName];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //渲染的同时设置主题
    [self setThemeName];
    
    _mainController = [[MainViewController alloc] init];
    LeftViewController *leftController = [[LeftViewController alloc] init];
    RightViewController *rightController = [[RightViewController alloc] init];
    
    DDMenuController *menuController = [[DDMenuController alloc] initWithRootViewController:_mainController];
    menuController.leftViewController = leftController;
    menuController.rightViewController = rightController;
    
    [self _initSinaWeibo];
    
    self.window.rootViewController = menuController;
    [menuController release];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
