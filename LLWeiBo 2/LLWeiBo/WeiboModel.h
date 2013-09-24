//
//  WeiboModel1.h
//  LLWeiBo
//
//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "WXBaseModel.h"
#import "UserModel.h"

@interface WeiboModel : WXBaseModel

@property(nonatomic,copy)NSString             *creaeData;         //创建时间
@property(nonatomic,copy)NSNumber             *weiboId;           //微薄ID
@property(nonatomic,copy)NSString             *text;              //微薄信息内容
@property(nonatomic,copy)NSString             *source;            //微薄来源
@property(nonatomic,retain)NSNumber           *favorited;         //是否已收藏，true：是，false：否
@property(nonatomic,copy)NSString             *thumnailImage;     //缩略图片地址，没有时不返回此字段
@property(nonatomic,copy)NSString             *bmiddleImage;      //中等尺寸图片地址，没有时不返回此字段
@property(nonatomic,copy)NSString             *originalImage;     //原始图片地址，没有时不返回此字段
@property(nonatomic,retain)NSDictionary       *geo;               //地理信息字段
@property(nonatomic,retain)WeiboModel        *relWeibo;          //转发的源微薄对象
@property(nonatomic,retain)UserModel         *user;              //微薄作者用户
@property(nonatomic,retain)NSNumber          *repostsCount;      //转发数
@property(nonatomic,retain)NSNumber          *commentsCount;     //评论数

@end
