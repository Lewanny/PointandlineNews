

//
//  LhyHotPot_WebViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/20.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyHotPot_WebViewController.h"

@interface LhyHotPot_WebViewController ()

@end

@implementation LhyHotPot_WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
     [self.navigationController setNavigationBarHidden:NO animated:YES];
     NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
     [center postNotificationName:@"showTabbar" object:nil];
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
