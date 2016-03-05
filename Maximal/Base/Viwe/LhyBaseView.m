//

//  LhyBaseView.m
//  NewAttitudes
//
//  Created by 李宏远 on 15/11/6.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseView.h"
#import "ConfigurationTheme.h"

@interface LhyBaseView ()

@property(nonatomic, retain)UIColor *defaultColor;

@property(nonatomic, copy)NSString *readStr;


@end

@implementation LhyBaseView
- (void)dealloc {
    
    [_defaultColor release];
    [super dealloc];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
   
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        /* 读取本地文件 */
        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
        self.readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        /* 注册消息 */
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
        
        if ([self.readStr isEqualToString:@"YES"]) {
            self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"NewBarColor"];
        } else {
            self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
        }
        
        self.alpha = 0.85;
        self.backgroundColor = self.defaultColor;
        
    }
    
    return self;
    
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"NewBarColor"];
    } else {
        
        self.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
    }
    
    
}


@end
