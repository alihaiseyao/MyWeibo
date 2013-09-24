//
//  WeiboView.h
//  LLWeiBo
//
//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RTLabel.h"

#define kWeibo_width_list (320 - 60) //微博在列表中的宽度
#define kWeibo_width_Detail 300      //微博在详情页面的宽度

@class WeiboModel;
@class ThemeImageView;
@interface WeiboView : UIView<RTLabelDelegate>{
    
@private
    RTLabel         *_textlabel;    //微薄内容
    UIImageView     *_image;        //微薄图片
    ThemeImageView     *_repostBackgroundView; //转发的微博视图背景
    WeiboView       *_repostView;   //转发的微薄视图
}

//微薄对象
@property(nonatomic,retain)WeiboModel   *weiboModel;


//当前的微博视图是否是转发的微薄视图
@property(nonatomic,assign)BOOL         isRepost;

//当前的微博视图是否是显示在详情页面
@property(nonatomic,assign)BOOL         isDetail;

//返回字体的大小
+ (float)getFontSizeisDetail:(BOOL)isDetail isRepost:(BOOL)isRepost;

//计算微博视图的高度
+(CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel isRepost:(BOOL)isRepost isDetail:(BOOL)isDetail;

@end
