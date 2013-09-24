//
//  WeiboCell.m
//  LLWeiBo
//
//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "WeiboCell.h"
#import <QuartzCore/QuartzCore.h>
#import "WeiboView.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"

@implementation WeiboCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initView];
    }
    return self;
}

//初始化子视图
-(void)_initView{
    //用户头像
    _userImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    _userImage.backgroundColor = [UIColor clearColor];
    _userImage.layer.cornerRadius = 5;  //圆弧半径 
    _userImage.layer.borderWidth = .5;  
    _userImage.layer.borderColor = [UIColor grayColor].CGColor;
    _userImage.layer.masksToBounds = YES;
    [self.contentView addSubview:_userImage];
    
    //昵称
    _nickLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickLabel.backgroundColor = [UIColor clearColor];
    _nickLabel.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_nickLabel];
    
    //转发数
    _repostCountLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _repostCountLabel.font = [UIFont systemFontOfSize:12.0];
    _repostCountLabel.backgroundColor = [UIColor clearColor];
    _repostCountLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_repostCountLabel];
    
    //回复数
    _commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _commentLabel.font = [UIFont systemFontOfSize:12.0];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_commentLabel];
    
    //微博来源
    _sourceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _sourceLabel.font = [UIFont systemFontOfSize:12.0];
    _sourceLabel.backgroundColor = [UIColor clearColor];
    _sourceLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_sourceLabel];
    
    //发布时间
    _createLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _createLabel.font = [UIFont systemFontOfSize:12.0];
    _createLabel.backgroundColor = [UIColor clearColor];
    _createLabel.textColor = [UIColor blueColor];
    [self.contentView addSubview:_createLabel];
    
    _weiboView = [[WeiboView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_weiboView];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    //------------------用户头像视图_userImage-------------------
    _userImage.frame = CGRectMake(5, 5, 35, 35);
    NSLog(@"+++++++%@",_weiboModel.user);
    NSString *userImageUrl = _weiboModel.user.profile_image_url;
    [_userImage setImageWithURL:[NSURL URLWithString:userImageUrl]];

    //-------------------昵称_nickLabel-----------------
    _nickLabel.frame = CGRectMake(50, 5, 200, 20);
    _nickLabel.text = _weiboModel.user.screen_name;
    
    //-------------------微薄视图-----------------
    _weiboView.weiboModel = _weiboModel;
    float height = [WeiboView getWeiboViewHeight:_weiboModel isRepost:NO isDetail:NO];
    _weiboView.frame = CGRectMake(50, _nickLabel.bottom + 10,(320-60), height);
    
}

@end
