//
//  ThemeButton.h
//  LLWeiBo
//
//  Created by apple  on 13-9-17.
//  Copyright (c) 2013年 microsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ThemeButton : UIButton

@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *highLightImageName;

@property(nonatomic,copy)NSString *backgroundImageName;
@property(nonatomic,copy)NSString *backgroundHighLightImageName;

-(id)initWithImage:(NSString *)imageName hightLighted:(NSString *)highLightImageName;
-(id)initWithBackground:(NSString *)backgroundImageName
        highLightedBackground:(NSString *)backgroundHighLightImageName;

@end
