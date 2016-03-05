//
//  LhyTabele_01_webViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/16.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyTabele_01_webViewController.h"
#import <WebKit/WebKit.h>
#import "DataHanlder.h"
#import "LhyMainTb_01Model.h"
#import "LhyBaseBottomView.h"

#import "LhyBaseView.h"
#import "UMSocial.h"


@interface LhyTabele_01_webViewController ()

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)LhyBaseBottomView *viewBottom;

@property(nonatomic, retain)WKWebView *wkWebView;

@property(nonatomic, retain)LhyBaseView *headView;
@property(nonatomic, retain)UIView *bgView;
@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UILabel *labelAuthorName;


@property(nonatomic, retain)UIButton *buttonCollection;
@property(nonatomic, assign)BOOL selectedButton;

@property(nonatomic, retain)UIButton *buttonShare;

@end

@implementation LhyTabele_01_webViewController


- (void)dealloc {
    
    [_model release];
    [_titleOfArticle release];
    [_bgView release];
    [_headView release];
    [_wkWebView release];
    [_webUrl release];
    [_viewBottom release];
    
    
    /* 销毁坚挺着 */
    [self.wkWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    [super dealloc];
    
}

#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated{
    
/* 查找数据库, 判断该数据是否收藏过 */
    
   NSMutableArray *arr = [[DataHanlder sharedDataBaseCreate] selectInfoWithTitle:self.titleOfArticle];
    LhyMainTb_01Model *model = [arr firstObject];
    
    if ([model.title isEqualToString:self.titleOfArticle]) {
        
        [self.buttonCollection setImage:[UIImage imageNamed:@"life_favorited"] forState:UIControlStateNormal];
        self.selectedButton = YES;
    } else {
//
        self.selectedButton = NO;
//        [self.buttonCollection setImage:[UIImage imageNamed:@"life_unfavorited"] forState:UIControlStateNormal];
        
    }
    
    
}

#pragma mark - 页面将要出现
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWKWebView];
    [self createBGView];
    [self createReturnButton];
    [self createHeadView];
    [self createButtonCollection];
    NSLog(@"%@", self.titleOfArticle);
    
    [[DataHanlder sharedDataBaseCreate] openDB];
    [[DataHanlder sharedDataBaseCreate] createTable];
    
//    /* 打开数据库, 创建表格 */
//    [[DataHanlder sharedDataBaseCreate] openDB];
//    [[DataHanlder sharedDataBaseCreate] createTable];
//

}

/* 创建headView和两个label */
- (void)createHeadView {
    
    self.headView = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 5)];
   // self.headView.backgroundColor = [UIColor colorWithRed:106/ 255.0 green:76/ 255.0 blue:143 / 255.0 alpha:1];
    [self.view addSubview:self.headView];
   
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 55, self.view.frame.size.width - 30, 20)];
    [self.headView addSubview:self.labelTitle];
    self.labelTitle.text = self.titleOfArticle;
    self.labelTitle.font = [UIFont boldSystemFontOfSize:20];
    self.labelTitle.textColor = [UIColor whiteColor];
  //  self.labelTitle.backgroundColor = [UIColor grayColor];
    
    
    self.labelAuthorName = [[UILabel alloc] initWithFrame:CGRectMake(15, 86, 80, 10)];
    [self.headView addSubview:self.labelAuthorName];
    self.labelAuthorName.text = self.nameOfAuthor;
    self.labelAuthorName.font = [UIFont systemFontOfSize:12];
    self.labelAuthorName.textColor = [UIColor whiteColor];
  //  self.labelAuthorName.backgroundColor = [UIColor grayColor];
    
    
    [self.labelTitle release];
    [self.labelAuthorName release];
    [self.headView release];
    
    
}

/* 创建bgView */
- (void)createBGView {
    
    
    self.bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 5)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bgView];
    [self.bgView release];
    
}

#pragma mark - 创建WKWebView
- (void)createWKWebView {
    
    
    self.wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height / 5 - 65 - 130, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height+ 130)];
    [self.view addSubview:self.wkWebView];
    [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    NSLog(@"%@", self.webUrl);
    /* 允许滑动回弹 */
    self.wkWebView.allowsBackForwardNavigationGestures = YES;
    /* 添加监听事件 */
    [self.wkWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    [self.wkWebView release];
    
}

#pragma mark - KVO监听WKWebView的偏移量
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    
    CGFloat newY = [[change objectForKey:@"new"] CGPointValue].y;
    NSLog(@"%f", newY);
//    
//    /* 根据newY固定两个View的frame */
//    self.headView.frame = CGRectMake(0, -1 * newY - 20, self.view.frame.size.width, self.view.frame.size.height / 5);
    //self.bgView.frame = CGRectMake(0, -1 * newY - 20, self.view.frame.size.width, self.view.frame.size.height / 5);
//    
//    if (newY < self.view.frame.size.height / 5 - 40) {
//        self.wkWebView.frame = CGRectMake(0, self.view.frame.size.height / 5 - 65 - 130 + (self.view.frame.size.height / 5 - 40 - newY), self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height+ 130);
//    } else if (newY < self.view.frame.size.height / 5 - 40) {
//        
//        self.wkWebView.frame = CGRectMake(0, self.view.frame.size.height / 5 - 65 - 130, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height+ 130);
//        self.bgView.frame = CGRectMake(0, 0 - newY, self.view.frame.size.width, self.view.frame.size.height / 5);
//    }
    
    
    if (newY <= - 20) {
        self.headView.frame = CGRectMake(0, -1 * newY - 20, self.view.frame.size.width, self.view.frame.size.height / 5);
    } else if (newY > -20 && newY <= self.view.frame.size.height / 5 - 40){
        
        self.headView.frame = CGRectMake(0, -(newY + 20), self.view.frame.size.width, self.view.frame.size.height / 5);
        self.bgView.frame = CGRectMake(0, -(newY + 20), self.view.frame.size.width, self.view.frame.size.height / 5);
    }
    
    if (newY  <= self.view.frame.size.height / 5 - 40) {

    } else if (newY > self.view.frame.size.height / 5 - 40) {
        
        self.headView.frame = CGRectMake(0, -self.view.frame.size.height / 5 +20,  self.view.frame.size.width, self.view.frame.size.height / 5);
        self.bgView.frame = CGRectMake(0, -self.view.frame.size.height / 5 +20, self.view.frame.size.width, self.view.frame.size.height / 5);
        
    }
    
}


#pragma mark - 返回按钮和分享按钮的创建和底部View点击方法
/* 按钮和view的创建 和显示当前页码的view */
- (void)createReturnButton {
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
    
    self.buttonShare = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonShare.frame = CGRectMake((self.view.frame.size.width - 30) / 2, 5, 30, 30);
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
                                      shareText:[NSString stringWithFormat:@"%@%@%@%@", self.titleOfArticle , @" 详见", self.webUrl,@" -- 最全面新闻资讯, 最好玩的社区平台, 尽在Maximal."]
                                     shareImage:[UIImage imageNamed:@"3"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina, UMShareToDouban,  nil]
                                       delegate:nil];
    
}

/* 返回button的点击方法 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
  
   
    
    [self.navigationController popViewControllerAnimated:YES];
    
   // [self.navigationController setNavigationBarHidden:NO animated:YES];
   // NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
   // [center postNotificationName:@"showTabbar" object:nil];
}




#pragma mark - 收藏按钮
- (void)createButtonCollection {
    
    /* 收藏按钮 */
    self.buttonCollection = [UIButton buttonWithType:UIButtonTypeCustom];
   
    
    [self.buttonCollection setImage:[UIImage imageNamed:@"life_unfavorite"] forState:UIControlStateNormal];
    
    self.buttonCollection.frame = CGRectMake(self.view.frame.size.width - 40, 5, 30, 30);
    [self.viewBottom addSubview:self.buttonCollection];
    [self.buttonCollection addTarget:self action:@selector(handleCollectionButton:) forControlEvents:UIControlEventTouchUpInside];

}
/* 收藏按钮的点击方法 */
- (void)handleCollectionButton:(UIButton *)buttonCollection {
    
        if (self.selectedButton == YES) {
            [self.buttonCollection setImage:[UIImage imageNamed:@"life_unfavorite"] forState:UIControlStateNormal];
            [[DataHanlder sharedDataBaseCreate] deledateInfoWithTitle:self.titleOfArticle];
            self.selectedButton = NO;
            
        } else {
            [self.buttonCollection setImage:[UIImage imageNamed:@"life_favorited"] forState:UIControlStateNormal];
            [[DataHanlder sharedDataBaseCreate] insertInfoWithModel:self.model];
            self.selectedButton = YES;
        }
   


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
