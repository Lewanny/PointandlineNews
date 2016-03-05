//
//  ConfigurationTheme.h
//  Theme
//
//  Created by 张鹏伟 on 15/8/20.
//  Copyright (c) 2015年 108. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ConfigurationTheme : NSObject



//创建单例,确保该对象唯一
+ (ConfigurationTheme *)shareInstance;

//获取当前主题下的颜色
- (UIColor *)getThemeColorWithName:(NSString *)colorName;





@end
