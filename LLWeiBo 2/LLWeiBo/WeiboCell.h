//
//  WeiboCell.h
//  LLWeiBo
//自定义微博

//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WeiboView;
@class WeiboModel;
@interface WeiboCell : UITableViewCell{

    UIImageView     *_userImage;         //用户头像视图
    UILabel         *_nickLabel;        //昵称
    UILabel         *_repostCountLabel; //转发数
    UILabel         *_commentLabel;     //回复数
    UILabel         *_sourceLabel;      //发布来源
    UILabel         *_createLabel;      //发布时间
}

//微博数据模型对象
@property(nonatomic,retain)WeiboModel *weiboModel;
//微博视图
@property(nonatomic,retain)WeiboView  *weiboView;

@end
