//
//  LhyGuidePageViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/24.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyGuidePageViewController.h"
#import "AppDelegate.h"

#import "LhyLoginInViewController.h"

@interface LhyGuidePageViewController ()<UIScrollViewDelegate>

@property(nonatomic, retain)UIScrollView *scrollView;
@property(nonatomic, retain)UIImageView *imageViewPic;
@property(nonatomic, retain)NSMutableArray *picArr;
@property(nonatomic, retain)UIPageControl *pageControl;

@property(nonatomic, retain)UIButton *buttonNext;
@property(nonatomic, retain)UIButton *buttonLogin;

@property(nonatomic, retain)NSString *pageType;

@end

@implementation LhyGuidePageViewController


- (void)dealloc {
    
    [_scrollView release];
    [_imageViewPic release];
    [_picArr release];
    [_pageControl release];
    [_pageType release];
    
    [super dealloc];
    
}


/* 单例创建VC */
+ (instancetype)sharedGuideVC {
    
    static LhyGuidePageViewController *guidePageVC = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        guidePageVC = [[LhyGuidePageViewController alloc] init];
    });
    
    return guidePageVC;
}


#pragma mark - 创建scrollView
- (void)createScrollView {
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.scrollView];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width * 4, self.view.frame.size.height);
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    /* 创建imageView */
    for (int i = 1; i < 5; i++) {
        
        self.imageViewPic = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*(i - 1), 0,self.view.frame.size.width, self.view.frame.size.height)];
        self.imageViewPic.image = [self.picArr objectAtIndex:i - 1];
        [self.scrollView addSubview:self.imageViewPic];
        self.imageViewPic.tag = i * 100;
        [self.imageViewPic release];
        if (i == 4) {
            /* 下一页按钮 */
            self.buttonNext = [UIButton buttonWithType:UIButtonTypeCustom];
            self.buttonNext.frame = CGRectMake((self.view.frame.size.width - 280) / 2 + self.view.frame.size.width * 3 , self.view.frame.size.height - 120, 120, 40);
            [self.buttonNext setTitle:@"点此进入" forState:UIControlStateNormal];
            [self.buttonNext addTarget:self action:@selector(handleGoInApp:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:self.buttonNext];
            self.buttonNext.layer.borderWidth = 2;
            self.buttonNext.layer.borderColor = [UIColor colorWithRed:0.656 green:0.688 blue:0.869 alpha:1.000].CGColor;
            self.buttonNext.layer.cornerRadius = 5;
            
            
            /* 登陆按钮 */
            self.buttonLogin = [UIButton buttonWithType:UIButtonTypeCustom];
            self.buttonLogin.frame = CGRectMake((self.view.frame.size.width - 280) / 2 + 160 + self.view.frame.size.width * 3 , self.view.frame.size.height - 120, 120, 40);
            [self.buttonLogin setTitle:@"账号登陆" forState:UIControlStateNormal];
            [self.buttonLogin addTarget:self action:@selector(handleLoginInApp:) forControlEvents:UIControlEventTouchUpInside];
            [self.scrollView addSubview:self.buttonLogin];
            self.buttonLogin.layer.borderWidth = 2;
            self.buttonLogin.layer.borderColor = [UIColor colorWithRed:0.656 green:0.688 blue:0.869 alpha:1.000].CGColor;
            self.buttonLogin.layer.cornerRadius = 5;
            
        }
        
    }
    
    
    [self.scrollView release];
    
}

#pragma mark - 两个button点击方法

- (void)handleLoginInApp:(UIButton *)button {
    
    
    NSLog(@"登陆界面");
    LhyLoginInViewController *loginInVC = [[LhyLoginInViewController alloc] init];
    loginInVC.pageType = self.pageType;
    [self presentViewController:loginInVC animated:YES completion:^{
        
    }];
    [loginInVC release];
    
}

/* 进入按钮点击方法 */
- (void)handleGoInApp:(UIButton *)button {
    [UIView animateWithDuration:1 animations:^{
        
        /* 改变透明度, 并重新指定跟视图 */
        UIImageView *imageViewPic = [self.scrollView viewWithTag:400];
        imageViewPic.alpha = 0.1;
        self.buttonLogin.alpha = 0.1;
        self.buttonNext.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        /* 重新指定跟视图 */
        AppDelegate *tempAppDelegate = [UIApplication sharedApplication].delegate;
        tempAppDelegate.window.rootViewController = tempAppDelegate.tb;
       
    }];

    
    
}

#pragma mark - pageControl
- (void)createPageControl {
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 40)/ 2, self.view.frame.size.height - 50, 40, 20)];
    [self.view addSubview:self.pageControl];
    self.pageControl.numberOfPages = 4;
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:0.278 green:0.312 blue:0.541 alpha:1.000];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.702 alpha:1.000];
    [self.pageControl release];
    
}

#pragma mark - 协议方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.pageControl.currentPage = self.scrollView.contentOffset.x / self.view.frame.size.width;
    
}


#pragma mark - 页面加载完成
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageType= @"guide";
    
    self.picArr = @[[UIImage imageNamed:@"guidePage_01"], [UIImage imageNamed:@"guidePage_02"], [UIImage imageNamed:@"guidePage_03"], [UIImage imageNamed:@"guidePage_04"]].mutableCopy;

    /* 程序是否为第一次启动 */
    if ([[NSUserDefaults standardUserDefaults]boolForKey:@"firstLaunch"] == NO) {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"firstLaunch"];
        [self createScrollView];
        [self createPageControl];
        
    } else {
        AppDelegate *tempAppDelegate = [UIApplication sharedApplication].delegate;
        tempAppDelegate.window.rootViewController = tempAppDelegate.tb;

        
    }

 //   [self createScrollView];
 //   [self createPageControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
