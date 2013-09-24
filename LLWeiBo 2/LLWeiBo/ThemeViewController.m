//
//  ThemeViewController.m
//  LLWeiBo
//
//  Created by apple  on 13-9-18.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "ThemeViewController.h"
#import "CONSTS.h"
#import "ThemeManager.h"
#import "UIFactory.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        themes = [[ThemeManager shareManager].themesPlist allKeys];
        NSLog(@"%@",[ThemeManager shareManager]);
        NSLog(@"%@",[ThemeManager shareManager].themesPlist);
        [themes retain];
        
        
        self.title = @"主题切换";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return themes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *indetifer = @"themeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indetifer];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indetifer];
        
        UILabel *textlabel = [UIFactory createLabel:kThemeListLabel];
        textlabel.frame = CGRectMake(10, 10, 200, 30);
        textlabel.backgroundColor = [UIColor clearColor];
        textlabel.font = [UIFont boldSystemFontOfSize:16.0f];
        textlabel.tag = 2013;
        [cell.contentView addSubview:textlabel];
    }
//    cell.textLabel.text = themes[indexPath.row];
    UILabel *textLabel = (UILabel *)[cell.contentView viewWithTag:2013];
    NSString *name  = themes[indexPath.row];
    textLabel.text = name;
    
    NSString *themeName = [ThemeManager shareManager].themeName;
    if (themeName == nil) {
        themeName = @"normal";
    }
    
    /*
     当刷新数据的时候,会依次生成一个个cell这样不想等的就会自动清除选择
     */
    if ([themeName isEqualToString:name]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *themeName = themes[indexPath.row];
    
    if ([themeName isEqualToString:@"normal"]) {
        themeName = nil;
    }
    
    //保存主题到本地
    [[NSUserDefaults standardUserDefaults] setObject:themeName forKey:kThemeName];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    [ThemeManager shareManager].themeName = themeName;
    [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:themeName];
    
    [tableView reloadData];
    
    /**
     - (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
     {
     int row = [indexPath row];
     int oldRow = [lastIndexPath row];
     if (newRow != oldRow)
     {
     UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
     newCell.accessoryType = UITableViewCellAccessoryCheckmark;
     
     UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath];
     oldCell.accessoryType = UITableViewCellAccessoryNone;
     
     lastIndexPath = indexPath;
     }
     else
     {
     UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
     newCell.accessoryType = UITableViewCellAccessoryCheckmark;
     lastIndexPath = indexPath;
     }
     
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
     }
     */
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
@end
