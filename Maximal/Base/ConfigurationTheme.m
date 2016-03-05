//
//  ConfigurationTheme.m
//  Theme
//
//  Created by 张鹏伟 on 15/8/20.
//  Copyright (c) 2015年 108. All rights reserved.
//

#import "ConfigurationTheme.h"

@interface ConfigurationTheme ()
@property (nonatomic, retain) NSDictionary *themeColorConfig; //字体的配置信息

@end

@implementation ConfigurationTheme

//创建单例,确保该对象唯一
+ (ConfigurationTheme *)shareInstance{
    
    static ConfigurationTheme *configuration = nil;
    if (configuration == nil) {
        configuration = [[ConfigurationTheme alloc] init];
    }
    return configuration;
}

//重写init方法
-(instancetype)init{
    
    self = [super init];
    if (self) {
 
        //读取颜色配置文件
        NSString *themeColorplist = [[NSBundle mainBundle] pathForResource:@"ThemeColor" ofType:@"plist"];
        self.themeColorConfig = [NSDictionary dictionaryWithContentsOfFile:themeColorplist];

    }
    
    return  self;
}



//获取当前主题下的颜色
- (UIColor *)getThemeColorWithName:(NSString *)colorName{

    
    NSString *rgb = [self.themeColorConfig objectForKey:colorName];
    NSArray *rgbs = [rgb componentsSeparatedByString:@","];
    
    if (rgbs.count == 3)
    {
        float r = [rgbs[0] floatValue];
        float g = [rgbs[1] floatValue];
        float b = [rgbs[2] floatValue];
        UIColor *color = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1];
        return color;
    }
    
    return nil;
}




@end
