
//
//  LhySelected_WebViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/18.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhySelected_WebViewController.h"
#import <WebKit/WebKit.h>
#import "LhyCommunity_SelectedModel.h"
#import "LhyBaseBottomView.h"

@interface LhySelected_WebViewController ()

@property(nonatomic, retain)WKWebView *wkWebView;

@property(nonatomic, retain)UIView* headTitleView;
@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)UILabel *labelTitle;

@property(nonatomic, retain)LhyBaseBottomView* viewBottom;

@end

@implementation LhySelected_WebViewController

- (void)dealloc {
    
    [_model release];
    [_wkWebView release];
    [_headTitleView release];
    [_labelTitle release];
    [_viewBottom release];
    [super dealloc];
    
}


#pragma mark - 创建头部视图
- (void)createHeadTitleViewAndButtonAndLabelTitle {
    
    self.headTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.headTitleView.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
    [self.view addSubview:self.headTitleView];
    
//    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
//    self.buttonReturn.frame = CGRectMake(15, 25, 30, 30);
//    self.buttonReturn.tintColor = [UIColor whiteColor];
//    
//    [self.headTitleView addSubview:self.buttonReturn];
//    /* 按钮添加点击方法 */
//    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
//    
//    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(100, 27, 175, 25)];
//    // self.labelTitle.backgroundColor = [UIColor grayColor];
//    self.labelTitle.textColor = [UIColor whiteColor];
//   // self.labelTitle.text = self.titleOfHeadView;
//    [self.headTitleView addSubview:self.labelTitle];
//    self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
//    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    
   // [self.labelTitle release];
    [self.headTitleView release];
    
}



#pragma mark - 返回按钮和底部View的创建和点击方法
/* 按钮和底部view的创建*/
- (void)createReturnButtonAndButtomView {
    /* 底部view */
    self.viewBottom = [[LhyBaseBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    //self.viewBottom.backgroundColor = [UIColor colorWithWhite:0.955 alpha:1.000];
    [self.view addSubview:self.viewBottom];
    self.viewBottom.layer.borderWidth = 1;
    self.viewBottom.layer.borderColor = [UIColor colorWithWhite:0.799 alpha:1.000].CGColor;
    
    //  self.viewBottom.backgroundColor = [UIColor colorWithRed:106/ 255.0 green:76/ 255.0 blue:143 / 255.0 alpha:1];
    
    /* 返回按钮 */
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.buttonReturn setImage:[UIImage imageNamed:@"common_icon_return"] forState:UIControlStateNormal];;
    self.buttonReturn.frame = CGRectMake(10, 5, 30, 30);
    [self.viewBottom addSubview:self.buttonReturn];
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.viewBottom release];
}

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    //  [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    //
    [self.navigationController popViewControllerAnimated:YES];
    
    /* 显示两个bar */
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabbar" object:nil];
    
    
}


#pragma mark - 创建WKWebView
- (void)createWkWebView {
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height- 60)];
    [self.view addSubview:self.wkWebView];
    NSLog(@"%@", self.model.weburl);
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.model.weburl]]];
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    
    [self.wkWebView release];
}


#pragma mark - 页面将要加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createReturnButtonAndButtomView];
    [self createHeadTitleViewAndButtonAndLabelTitle];
    [self createWkWebView];
    
    
   // self.navigationController.automaticallyAdjustsScrollViewInsets = NO;
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
