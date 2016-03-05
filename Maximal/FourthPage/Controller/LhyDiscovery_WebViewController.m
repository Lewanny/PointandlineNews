//

//  LhyDiscovery_WebViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyDiscovery_WebViewController.h"

@interface LhyDiscovery_WebViewController ()

@end

@implementation LhyDiscovery_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 重新父类的点击方法, 使返回时两个bar不会出现

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    //  [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //
    [self.navigationController popViewControllerAnimated:YES];
//    
//    /* 显示两个bar */
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabbar" object:nil];
    
    
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
