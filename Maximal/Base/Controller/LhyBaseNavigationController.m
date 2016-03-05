//
//  LhyBaseNavigationController.m
//  NewAttitudes
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyBaseNavigationController.h"
#import "ConfigurationTheme.h"

@interface LhyBaseNavigationController ()

@property(nonatomic, retain)UIColor *defaultColor;
@property(nonatomic, copy)NSString *readStr;

@end

@implementation LhyBaseNavigationController

- (void)dealloc {
    
    [_readStr release];
    [_defaultColor release];
    [super dealloc];
}





- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    self.readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    
    self = [super initWithRootViewController:rootViewController];
    if (self) {
        
        /* 设置导航栏的样式 */
        
        /* 主体颜色 */
        if ([self.readStr isEqualToString:@"YES"]) {
            self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"NewBarColor"];
        } else {
            
            self.defaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
        }
        
        self.navigationBar.barTintColor = self.defaultColor;
        NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[[UIColor whiteColor], [UIFont boldSystemFontOfSize:16]] forKeys:@[NSForegroundColorAttributeName, NSFontAttributeName]];
        self.navigationBar.titleTextAttributes = dic;
        
//        /* 设置导航栏左侧个人信息按钮 */
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SocialTabBarItemProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(handleInfoButton:)];
//        self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    }
    return self;
} 


- (UIViewController *)childViewControllerForStatusBarStyle {
    
    return self.visibleViewController;
    
}



/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.navigationBar.barTintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"NewBarColor"];
    } else {
        
        self.navigationBar.barTintColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"DefaultBarColor"];
    }
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
