

//
//  LhyEnjoy_More_WebViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/17.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_More_WebViewController.h"
#import <WebKit/WebKit.h>
#import "LhyBaseView.h"
#import "LhyBaseBottomView.h"

#import "UMSocial.h"


@interface LhyEnjoy_More_WebViewController ()

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)LhyBaseBottomView *viewBottom;

@property(nonatomic, retain)WKWebView *wkWebView;

@property(nonatomic, retain)LhyBaseView *headView;
@property(nonatomic, retain)UIView *bgView;

@property(nonatomic, retain)UIButton *buttonShare;



@end

@implementation LhyEnjoy_More_WebViewController


- (void)dealloc {
    
    
    [_titleOfArtical release];
    [_bgView release];
    [_headView release];
    [_wkWebView release];
    [_webUrl release];
    [_viewBottom release];
    [super dealloc];
    
}

#pragma mark - 页面将要出现
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWKWebView];
    [self createBGView];
    [self createReturnButton];
    
    //  [self createHeadView];
    
    
}

/* 创建headView */
- (void)createHeadView {
    
    self.headView = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 5)];
//    self.headView.backgroundColor = [UIColor colorWithRed:106/ 255.0 green:76/ 255.0 blue:143 / 255.0 alpha:1];
    [self.view addSubview:self.headView];
    
    
    [self.headView release];
    
    
}

/* 创建bgView */
- (void)createBGView {
    
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    self.bgView.backgroundColor = [UIColor colorWithWhite:0.842 alpha:1.000];
    [self.view addSubview:self.bgView];
    [self.bgView release];
    
}

#pragma mark - 创建WKWebView
- (void)createWKWebView {
    
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.wkWebView];
    NSLog(@"%@", self.webUrl);
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    
    /* 允许滑动回弹 */
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    //    /* 添加监听事件 */
    //    [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.wkWebView release];
    
}

#pragma mark - 返回按钮和底部View的创建和点击方法
/* 按钮和底部view的创建*/
- (void)createReturnButton {
    /* 底部view */
    self.viewBottom = [[LhyBaseBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
   // self.viewBottom.backgroundColor = [UIColor colorWithWhite:0.955 alpha:1.000];
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
    
    /* 分享按钮 */
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonShare.frame = CGRectMake(self.view.frame.size.width - 40, 5, 30, 30);
    [self.buttonShare setImage:[UIImage imageNamed:@"common_icon_share"] forState:UIControlStateNormal];
    [self.viewBottom addSubview:self.buttonShare];
    [self.buttonShare addTarget:self action:@selector(handleSahreButton:) forControlEvents:UIControlEventTouchUpInside];

    
    
    [self.viewBottom release];
}



#pragma mark - 分享功能
- (void)handleSahreButton:(UIButton *)button {
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"5654440ae0f55a1949000ef2"
                                      shareText:[NSString stringWithFormat:@"%@%@%@%@", self.titleOfArtical, @" 详见", self.webUrl,@" -- 最全面新闻资讯, 最好玩的社区平台, 尽在Maximal."]
                                     shareImage:[UIImage imageNamed:@"3"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToTencent, UMShareToWechatSession,UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ, UMShareToRenren, UMShareToDouban, UMShareToEmail, UMShareToSms, UMShareToFacebook, UMShareToTwitter,nil]
                                       delegate:nil];
    
}


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
