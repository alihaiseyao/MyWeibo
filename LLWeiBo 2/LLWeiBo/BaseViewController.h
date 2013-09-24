//
//  BaseViewController.h
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SinaWeibo.h"

@interface BaseViewController : UIViewController

@property(nonatomic,assign)BOOL isBackButton;

-(SinaWeibo *)sinaweibo;

@end
