//
//  BaseViewController.m
//  LLWeiBo
//
//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "BaseViewController.h"
#import "DVIAppDelegate.h"
#import "UIFactory.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.isBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && self.isBackButton) {
        UIButton *button = [UIFactory createButton:@"navigationbar_back.png" HighLightedName:@"navigationbar_back_highlighted.png"];
        button.frame = CGRectMake(0, 0, 24, 24);
        [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = backItem;
    }
}

-(void)backAction:(UIBarButtonItem *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//override
-(void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.textColor = [UIColor blackColor];
    UILabel *titleLabel = [[UIFactory createLabel:kNavigationBarTitleLabel] retain];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    
    self.navigationItem.titleView = [titleLabel autorelease];
}

-(SinaWeibo *)sinaweibo
{
    DVIAppDelegate *appDelegate = (DVIAppDelegate *)[UIApplication sharedApplication].delegate;
    SinaWeibo *sinaWeiBo =appDelegate.sinaWeiBo;
    return sinaWeiBo;
}

@end
