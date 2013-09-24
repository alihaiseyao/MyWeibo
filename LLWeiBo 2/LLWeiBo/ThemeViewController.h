//
//  ThemeViewController.h
//  LLWeiBo
//
//  Created by apple  on 13-9-18.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "BaseViewController.h"

@interface ThemeViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *themes;
}
@property (retain, nonatomic) IBOutlet UITableView *tableView;

@end
