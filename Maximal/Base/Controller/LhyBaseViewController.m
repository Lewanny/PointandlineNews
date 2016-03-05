//
//  LhyBaseViewController.m
//  NewAttitudes
//
//  Created by 李宏远 on 15/11/6.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseViewController.h"
#import "ConfigurationTheme.h"

@interface LhyBaseViewController ()

@end

@implementation LhyBaseViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.view.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCNewColor"];
    } else {
        
        self.view.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCDefaultColor"];
    }
    
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.907 alpha:1.000];
    
}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.view.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCNewColor"];
    } else {
        
        self.view.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"VCDefaultColor"];
    }
}



/* 状态栏颜色 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
