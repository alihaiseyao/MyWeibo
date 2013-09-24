//
//  WeiboModel1.m
//  LLWeiBo
//
//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "WeiboModel.h"

@implementation WeiboModel

-(NSDictionary *)atrributeMapDictionary{
    NSDictionary *mapAtt = @{
                              @"createDate":@"created_at",
                              @"weiboId":@"id",
                              @"text":@"text",
                              @"source":@"source",
                              @"favorited":@"favorited",
                              @"thumbnailImage":@"thumbnail_pic",
                              @"bmiddleImage":@"bmiddle_pic",
                              @"originalImage":@"original_pic",
                              @"geo":@"geo",
                              @"repostsCount":@"reposts_count",
                              @"commentsCount":@"comments_count"
                             };
    return mapAtt;
}

-(void)setAttributes:(NSDictionary *)dataDic{
    //将字典数据根据映射关系填充到当前对象的属性上
    [super setAttributes:dataDic];
    
    //转发的微薄对象
    NSDictionary *retWeetDic = [dataDic objectForKey:@"retweeted_status"];
    if (retWeetDic != nil) {
        WeiboModel *relWeibo = [[WeiboModel alloc] initWithDataDic:retWeetDic];
        self.relWeibo = relWeibo;
        [relWeibo release];
    }

    
    NSDictionary *userDic = [dataDic objectForKey:@"user"];
    if (userDic != nil) {
        UserModel *user = [[UserModel alloc] initWithDataDic:userDic];
        self.user = user;
        [user release];
    }
}


@end
