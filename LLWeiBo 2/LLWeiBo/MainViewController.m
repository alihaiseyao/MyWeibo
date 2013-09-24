//
//  MainViewController.m
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "MainViewController.h"
#import "HomeViewController.h"
#import "MessegeViewController.h"
#import "ProfileViewController.h"
#import "DiscoverViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"


#import "UIFactory.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tabBar setHidden:YES];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self _initViewController];
    [self _initTabbarView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//初始化控制器
-(void)_initViewController
{
    HomeViewController *home = [[HomeViewController alloc] init];
    MessegeViewController *messege = [[MessegeViewController alloc] init];
    ProfileViewController *profile = [[ProfileViewController alloc] init];
    DiscoverViewController *discover = [[DiscoverViewController alloc] init];
    MoreViewController *more = [[MoreViewController alloc] init];
    
    NSArray *views = @[home,messege,profile,discover,more];
    NSMutableArray *ViewControllers = [NSMutableArray arrayWithCapacity:5];
    for (UIViewController *viewController in views)
    {
        BaseNavigationController *nav = [[BaseNavigationController alloc]
                                         initWithRootViewController:viewController];
        [ViewControllers addObject:nav];
        [nav release];
    }
    
    self.viewControllers = ViewControllers;
    
}

//创建自定义tabBar
-(void)_initTabbarView{
    _tabbarView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 49 - 20, 320, 49)];
//    _tabbarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage  imageNamed:@"tabbar_background.png"]];
    [self.view addSubview:_tabbarView];
    
    UIImageView *tabbarGroundImage = [UIFactory createImageView:@"tabbar_background.png"];
    tabbarGroundImage.frame = _tabbarView.bounds;
    [_tabbarView addSubview:tabbarGroundImage];
    
    NSArray *background = @[@"tabbar_home.png",@"tabbar_message_center.png",
                            @"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    
    NSArray *heighlightBackground  = @[@"tabbar_home_highlighted.png",
                                       @"tabbar_message_center_highlighted.png",
                                       @"tabbar_profile_highlighted.png",
                                       @"tabbar_discover_highlighted.png",
                                       @"tabbar_more_highlighted.png"];
    for (int i = 0 ; i<background.count; i++) {
        NSString *backImageName = background[i];
        NSString  *heightlightImageName = heighlightBackground[i];
        

//        ThemeButton *button = [[ThemeButton alloc] initWithImage:backImageName hightLighted:heightlightImageName];
        UIButton *button = [UIFactory createButton:backImageName HighLightedName:heightlightImageName];
        button.frame = CGRectMake((64-30)/2 + (i*64), (49-30)/2, 30, 30);
        button.tag = i;
//        [button setImage:[UIImage imageNamed:backImageName] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:heightlightImageName] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabbarView addSubview:button];
    }
    
    _sliderView = [[UIFactory createImageView:@"tabbar_slider.png"] retain];
    _sliderView.backgroundColor = [UIColor clearColor];
    _sliderView.frame = CGRectMake((64-15)/2, 5, 15, 40);
    [_tabbarView addSubview:_sliderView];
    [_sliderView release];
}

-(void)selectedTab:(UIButton *)button{
    self.selectedIndex = button.tag;
    
    float x = button.left + (button.width - _sliderView.width)/2;
    [UIView animateWithDuration:0.2 animations:^{
        _sliderView.left = x;
    }];
}

#pragma mark - SinaWeibo delegate
- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"%s",__func__);
    //保存认证数据到磁盘
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken,@"AccessTokenKey",
                              sinaweibo.expirationDate,@"ExpirationDateKey",
                              sinaweibo.userID,@"UserIDKey",
                              sinaweibo.refreshToken,@"refresh_token",nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"%s",__func__);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}
- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"%s",__func__);
}

@end
