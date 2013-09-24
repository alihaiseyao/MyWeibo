//
//  ThemeImageView.h
//  LLWeiBo
//
//  Created by apple  on 13-9-21.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeImageView : UIImageView

@property(nonatomic,copy)NSString *imageName;

//截图操作
@property(nonatomic,assign)int leftCapWidth;
@property(nonatomic,assign)int  topCapHeight;

-(id)initWithImageName:(NSString *)imageName;

@end
