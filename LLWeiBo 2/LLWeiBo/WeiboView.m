//
//  WeiboView.m
//  LLWeiBo
//
//  Created by apple  on 13-9-22.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import "WeiboView.h"
#import "UIFactory.h"
#import "WeiboModel.h"
#import "UIImageView+WebCache.h"
#import "ThemeImageView.h"

#define LIST_FONT  14.0f        //列表中的微博内容字体
#define LIST_REPOST_FONT  13.0f //列表中的微博转发的文本字体
#define DETAIL_FONT  18.0f      //列表中的微博详情字体
#define DETAIL_REPOST_FONT  17.0f //列表中的微博转发的详情字体

@implementation WeiboView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}

- (void)_initView{
    
    //微博内容
    _textlabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    _textlabel.delegate = self;
    _textlabel.font = [UIFont systemFontOfSize:14.0f];
    _textlabel.linkAttributes = [NSDictionary dictionaryWithObject:@"purple" forKey:@"color"];
    _textlabel.selectedLinkAttributes = [NSDictionary dictionaryWithObject:@"darkGray" forKey:@"color"];
    [self addSubview:_textlabel];
    
    //微博图片
    _image = [[UIImageView alloc] initWithFrame:CGRectZero];
    _image.image = [UIImage imageNamed:@"page_image_loading.png"];
    _image.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_image];
    
    //转发的微博视图背景
    _repostBackgroundView = [UIFactory createImageView:@"timeline_retweet_background.png"];
    UIImage *image =  [_repostBackgroundView.image stretchableImageWithLeftCapWidth:25 topCapHeight:10];
    _repostBackgroundView.image = image;
    _repostBackgroundView.leftCapWidth = 25;
    _repostBackgroundView.topCapHeight = 10;
    _repostBackgroundView.backgroundColor = [UIColor clearColor];
    [self insertSubview:_repostBackgroundView atIndex:0];
}

- (void)setWeiboModel:(WeiboModel *)weiboModel{
    
    //重写微薄对象的set方法
    if (_weiboModel != weiboModel) {
        [_weiboModel release];
        _weiboModel = [weiboModel retain];
    }
    
    //如果转发视图为空,创建转发微博视图
    if (_repostView == nil) {
        _repostView = [[WeiboView alloc] initWithFrame:CGRectZero];
        _repostView.isRepost = YES;
        [self addSubview:_repostView];
    }
}

//layoutSubviews 用来展示数据,子视图布局
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //------微博内容_textlabel子视图--------
   float fontSize = [WeiboView getFontSizeisDetail:self.isDetail isRepost:self.isRepost];
    _textlabel.font = [UIFont systemFontOfSize:fontSize];
    _textlabel.frame = CGRectMake(0, 0, self.width, 20);
    //判断当前视图是否为转发视图
    if (self.isRepost) {
        _textlabel.frame = CGRectMake(10, 10, self.width - 20, 0);
    }
    _textlabel.text = _weiboModel.text;
    //文本内容尺寸
    CGSize textSize =  _textlabel.optimumSize;
    _textlabel.height = textSize.height;
    
    //------转发的微博视图_repostView--------
    //转发的微博model
    WeiboModel *repostWeibo = _weiboModel.relWeibo;
    if (repostWeibo != nil) {
        _repostView.weiboModel = repostWeibo;
        
       float height = [WeiboView getWeiboViewHeight:repostWeibo isRepost:YES isDetail:self.isDetail];
        _repostView.frame = CGRectMake(0, _textlabel.bottom, self.width, height);
        _repostView.hidden = NO;
        
    }else{
        
        _repostView.hidden = YES;
        
    }
    
    //------微薄图片视图--------
    NSString *thumbnailImage = _weiboModel.thumnailImage;
    if (thumbnailImage != nil && [@"" isEqualToString:thumbnailImage]) {
        _image.hidden = NO;
        _image.frame = CGRectMake(10, _textlabel.bottom, 70, 80);
        
        //加载网络图片数据
        [_image setImageWithURL:[NSURL URLWithString:thumbnailImage]];
    }else{
        //如果没有图片
        _image.hidden = YES;
    }
    
    //------转发微薄视图背景_repostBackgroundView--------
    
    if (self.isRepost) {
        
        _repostBackgroundView.frame = self.bounds;
        _repostBackgroundView.hidden = NO;
        
    }else{
        
        _repostBackgroundView.hidden = YES;
        
    }
}

+ (float)getFontSizeisDetail:(BOOL)isDetail isRepost:(BOOL)isRepost
{
    float fontSize = 14.0f;
    
    if (!isDetail && !isRepost) {
        return LIST_FONT;
    }else if (!isDetail && isRepost){
        return LIST_REPOST_FONT;
    }else if (isDetail && !isRepost){
        return DETAIL_FONT;
    }else if (isDetail && isRepost){
        return DETAIL_REPOST_FONT;
    }
    
    return fontSize;
}

+(CGFloat)getWeiboViewHeight:(WeiboModel *)weiboModel
                    isRepost:(BOOL)isRepost
                    isDetail:(BOOL)isDetail
{
    /*
     思路:计算每个子视图的高度,然后想加
     */
    float height = 0;
    
    //-----------------计算微博内容text高度------------------
    RTLabel *textLabel = [[RTLabel alloc] initWithFrame:CGRectZero];
    float fontSize = [WeiboView getFontSizeisDetail:isDetail isRepost:isRepost];
    textLabel.font = [UIFont systemFontOfSize:fontSize];
    
    //判断此微博是否显示在详情页面
    if (isDetail) {
        textLabel.width = kWeibo_width_Detail;
    }else{
        textLabel.width = kWeibo_width_list;
    }
    
    textLabel.text = weiboModel.text;
    height += textLabel.optimumSize.height;
    
    //-------------------计算微博图片的高度--------------------
    NSString *thumbnailImage = weiboModel.thumnailImage;
    //判断图片有没有url
    if (thumbnailImage != nil && [@"" isEqualToString:thumbnailImage]) {
        height += (80 + 10);
    }
    
    WeiboModel *relWeibo = weiboModel.relWeibo;
    if (relWeibo != nil) {
        //转发微博视图的高度
       float repostHeight =  [WeiboView getWeiboViewHeight:relWeibo isRepost:YES isDetail:NO];
        height += repostHeight;
    }
    
    if (isRepost == YES) {
        height += 30;
    }
    
    return height;
    
}


#pragma mark--RTLabelDelegate
- (void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL*)url
{
    
}

@end
