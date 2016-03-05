
//
//  LhyUserInfoViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/23.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyUserInfoViewController.h"
#import "LhyBaseView.h"

@interface LhyUserInfoViewController ()

@property(nonatomic, retain)LhyBaseView *headTitleView;
@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)UILabel *labelTitle;

@property(nonatomic, retain)UILabel *labelUserId;

@end

@implementation LhyUserInfoViewController


- (void)dealloc {
    
    [_titleName release];
    [_labelUserId release];
    [_headTitleView release];
    [_labelTitle release];
    [super dealloc];
}


- (void)createHeadTitleViewAndButtonAndLabelTitle {
    
    self.headTitleView = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    //    self.headTitleView.backgroundColor = [UIColor colorWithRed:0.001 green:0.722 blue:0.979 alpha:1.000];
    [self.view addSubview:self.headTitleView];
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    self.buttonReturn.frame = CGRectMake(15, 25, 30, 30);
    self.buttonReturn.tintColor = [UIColor whiteColor];
    
    [self.headTitleView addSubview:self.buttonReturn];
    /* 按钮添加点击方法 */
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 27, 175, 25)];
    // self.labelTitle.backgroundColor = [UIColor grayColor];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.text = self.titleName;
    [self.headTitleView addSubview:self.labelTitle];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    
    [self.labelTitle release];
    [self.headTitleView release];
    
}

/* 返回按钮点击方法的实现 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    
//    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
//    [center postNotificationName:@"showTabbar" object:nil];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self createHeadTitleViewAndButtonAndLabelTitle];
    self.labelUserId = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.labelUserId.center = self.view.center;
    self.labelUserId.text = @"您的资料正在火星...";
    [self.view addSubview:self.labelUserId];
    self.labelUserId.textAlignment = NSTextAlignmentCenter;
    self.labelUserId.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    self.labelUserId.font = [UIFont systemFontOfSize:22];
    
    
    
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
