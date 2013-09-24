//
//  HomeViewController.h
//  LLWeiBo
//首页控制器

//  Created by apple  on 13-9-14.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface HomeViewController : BaseViewController<SinaWeiboRequestDelegate,UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,retain)NSArray *data;

@end
