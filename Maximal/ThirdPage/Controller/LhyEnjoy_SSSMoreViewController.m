


//
//  LhyEnjoy_SSSMoreViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/17.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyEnjoy_SSSMoreViewController.h"
#import "LhyAFNetworkTool.h"

#import "LhyEnjoy_SSSTableViewCell.h"
#import "Lhy_Main_SSSModel.h"

#import "LhyBaseView.h"

//#import "LhyEnjoy_WebViewController.h"
#import "LhyEnjoy_More_WebViewController.h"

#import "MJRefresh.h"
#import "MBProgressHUD.h"

@interface LhyEnjoy_SSSMoreViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *modelArr;


@property(nonatomic, retain)LhyBaseView *headTitleView;
@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)UILabel *labelTitle;


@property(nonatomic, assign)BOOL isDelete;
@property(nonatomic, copy)NSString *currentUrlStr;
@property(nonatomic, copy)NSString *tempUrlStr;

@property(nonatomic, retain)MBProgressHUD *Loading;


@end

@implementation LhyEnjoy_SSSMoreViewController

- (void)dealloc {
    
    [_Loading release];
    [_currentUrlStr release];
    [_tempUrlStr release];
    [_titleOfHeadView release];
    [_labelTitle release];
    [_buttonReturn release];
    [_tableView release];
    [_modelArr release];
    [_headTitleView release];
    [_urlStr release];
    [super dealloc];
    
}

#pragma mark - 数据处理
- (void)handleData {
    [self.Loading show:YES];
    if (self.isDelete == YES) {
       // [self.modelArr removeAllObjects];
        self.currentUrlStr = self.urlStr;
    }
    
    [LhyAFNetworkTool getUrl:self.currentUrlStr body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.isDelete == YES) {
         //   [self.modelArr removeAllObjects];
            self.currentUrlStr = self.urlStr;
        }
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableDictionary *dicTem = [dic objectForKey:@"info"];
        self.tempUrlStr = [dicTem objectForKey:@"next_url"];
        
        NSMutableArray *arr = [dic objectForKey:@"weekends"];
        for (NSMutableDictionary *dic in arr) {
            
            Lhy_Main_SSSModel *model = [[Lhy_Main_SSSModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            [self.modelArr addObject:model];
            [model release];
        }

        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.modelArr.count == 0) {
                self.tableView.separatorStyle = 0;
            } else {
                self.tableView.separatorStyle = 1;
            }
            [self.tableView reloadData];
            [self.Loading hide:YES];
            
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
    
    
    
    
}



#pragma mark - 创建tableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, self.view.frame.size.height - 45)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[LhyEnjoy_SSSTableViewCell class] forCellReuseIdentifier:@"enjoy_SSSCell_01"];
    self.tableView.separatorStyle = 0;
    
    /* 下拉刷新 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"正在刷新数据");
        self.isDelete = YES;
        [self handleData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.mj_header = header;
    
    /* 上拉加载 */
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"正在加载数据");
         self.isDelete = NO;
        self.currentUrlStr = self.tempUrlStr;
        [self handleData];
        [self.tableView.mj_footer endRefreshing];
        
    }];
    self.tableView.mj_footer = footer;
    // [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    NSLog(@"%@", self.urlStr);
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
    self.labelTitle.text = self.titleOfHeadView;
    [self.headTitleView addSubview:self.labelTitle];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    
    [self.labelTitle release];
    [self.headTitleView release];
    
}

/* 返回按钮点击方法的实现 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    [self.navigationController popViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"showTabbar" object:nil];
}

#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 2;
    });
    [self.tableView reloadData];
    
    
}


#pragma mark - 页面加载完成
- (void)viewDidLoad {
    
    self.modelArr = [NSMutableArray array];
    self.currentUrlStr = self.urlStr;
    
    [super viewDidLoad];
    [self handleData];
    [self createTableView];
    
    [self createHeadTitleViewAndButtonAndLabelTitle];
    
    
}

#pragma mark - tableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.frame.size.height / 2 - 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyEnjoy_SSSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"enjoy_SSSCell_01"];
    cell.model = [self.modelArr  objectAtIndex:indexPath.row];
    return cell;
    
}

/* cell的点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Lhy_Main_SSSModel *model = [self.modelArr objectAtIndex:indexPath.row];
    
    NSLog(@"%@", model.pos_str);
    LhyEnjoy_More_WebViewController *webVC = [[LhyEnjoy_More_WebViewController alloc] init];
    webVC.webUrl = [model.weekend objectForKey:@"content_url"];
    webVC.titleOfArtical = model.title;
    NSLog(@"%@", webVC.webUrl);
    
    [self.navigationController pushViewController:webVC animated:YES];
    
    /* 隐藏两个bar */
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
    [webVC release];
    
    
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
