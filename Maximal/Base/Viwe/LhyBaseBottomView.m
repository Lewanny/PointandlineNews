
//
//  LhyBaseBottomView.m
//  Maximal
//
//  Created by 李宏远 on 15/11/23.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseBottomView.h"
#import "ConfigurationTheme.h"

@interface LhyBaseBottomView ()

@property(nonatomic, retain)UIColor *defaultColor;

@property(nonatomic, copy)NSString *readStr;


@end

@implementation LhyBaseBottomView
- (void)dealloc {
    
    [_defaultColor release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    self.readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    /* 主体颜色 */
    if ([self.readStr isEqualToString:@"YES"]) {
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewNewColor"];
    } else {
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewDefaultColor"];
    }
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.alpha = 0.95;
        self.backgroundColor = self.defaultColor;
        
    }
    
    return self;
    
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewNewColor"];
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewNewColor"];
    } else {
        
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewDefaultColor"];
        self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"BottomViewDefaultColor"];
    } 
}


@end
