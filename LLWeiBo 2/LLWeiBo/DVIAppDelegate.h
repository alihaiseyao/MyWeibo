//
//  DVIAppDelegate.h
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MainViewController;
@class SinaWeibo;
@interface DVIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)SinaWeibo *sinaWeiBo;
@property(nonatomic,retain)MainViewController *mainController;

@end
