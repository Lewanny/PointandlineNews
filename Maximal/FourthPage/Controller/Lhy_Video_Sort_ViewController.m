

//
//  Lhy_Video_Sort_ViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/20.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "Lhy_Video_Sort_ViewController.h"
#import "LhyBaseView.h"
#import "LhyTMovie_02_ableViewCell.h"
#import "Lhy_Community_Video_SidLstModel.h"

#import "Lhy_Community_Video_ListModel.h"
#import "MJRefresh.h"

#import "LhyAFNetworkTool.h"
#import "MBProgressHUD.h"

@interface Lhy_Video_Sort_ViewController ()<UITableViewDataSource, UITableViewDelegate>


@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)LhyBaseView *headTitleView;
@property(nonatomic, retain)UILabel *labelTitle;
@property(nonatomic, retain)UIButton *buttonReturn;

@property(nonatomic, retain)NSMutableArray *modelArr;

@property(nonatomic, assign)BOOL isDelete;
@property(nonatomic, assign)NSInteger beginIndex;
@property(nonatomic, assign)NSInteger endIndex;

@property(nonatomic, retain)MBProgressHUD *Loading;



@end


@implementation Lhy_Video_Sort_ViewController

- (void)dealloc  {
    
    [_Loading release];
    [_modelArr release];
    [_model release];
    [_tableView release];
    [_headTitleView release];
    [_labelTitle release];
    [_buttonReturn release];
    [super dealloc];
    
}

#pragma mark - 数据处理
- (void)handleData {
    [self.Loading show:YES];
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@%ld%@%ld%@", @"http://c.3g.163.com/nc/video/list/", self.model.sid,@"/y/", self.beginIndex, @"-", self.endIndex, @".html"];
    
    if (self.isDelete == YES) {
        [self.modelArr removeAllObjects];
        self.beginIndex = 0;
        self.endIndex = 10;
    }
    
  // NSString *url = [NSString stringWithFormat:@"%@%ld%@%ld%@", @"http://c.3g.163.com/nc/video/home/", self.beginIndex, @"-", self.endIndex, @".html"];
    
    
    [LhyAFNetworkTool getUrl:urlStr body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSMutableArray *arrSidList = [responseObject objectForKey:@"videoSidList"];
//        for (NSMutableDictionary *dic in arrSidList) {
//            
//            Lhy_Community_Video_SidLstModel *sidModel = [[Lhy_Community_Video_SidLstModel alloc] init];
//            [sidModel setValuesForKeysWithDictionary:dic];
//            [self.modelArr addObject:sidModel];
//            //   NSLog(@"%@", sidModel.title);
//            [sidModel release];
//            
//        }
//        
        
        NSMutableArray *arrList = [responseObject objectForKey:self.model.sid];
        for (NSMutableDictionary *dic in arrList) {
            Lhy_Community_Video_ListModel *model = [[Lhy_Community_Video_ListModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            NSLog(@"%@", model.title);
            [self.modelArr addObject:model];
            NSLog(@"%@", model.mp4_url);
            [model release];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.Loading hide:YES];
            
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    

    
    
}




#pragma mark - 创建头部视图和titleLabel
- (void)createHeadTitleViewAndButtonAndLabelTitle {
    
    self.headTitleView = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:self.headTitleView];
    
    //    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    //    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    //    self.buttonReturn.frame = CGRectMake(15, 25, 30, 30);
    //    self.buttonReturn.tintColor = [UIColor whiteColor];
    //
    //    [self.headTitleView addSubview:self.buttonReturn];
    //    /* 按钮添加点击方法 */
    //    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 27, 275, 25)];
    // self.labelTitle.backgroundColor = [UIColor grayColor];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.text = self.model.title;
    [self.headTitleView addSubview:self.labelTitle];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    
    [self.labelTitle release];
    [self.headTitleView release];
    
}


/* 创建返回按钮 */
- (void)createButtonReturn {
    
    self.buttonReturn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonReturn setImage:[UIImage imageNamed:@"circle_icon_back"] forState:UIControlStateNormal];
    self.buttonReturn.frame = CGRectMake(15, 25, 30, 30);
    self.buttonReturn.tintColor = [UIColor whiteColor];
    [self.view addSubview:self.buttonReturn];
    
    /* 按钮添加点击方法 */
    [self.buttonReturn addTarget:self action:@selector(handleReturnButton:) forControlEvents:UIControlEventTouchUpInside];
    
    
}


/* 返回按钮点击方法的实现 */
- (void)handleReturnButton:(UIButton *)buttonReturn {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"showTabbar" object:nil];
}

#pragma mark - 创建tableView
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[LhyTMovie_02_ableViewCell class] forCellReuseIdentifier:@"Movie_sortCell"];

    
    /* 下拉刷新 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"正在刷新数据");
        self.isDelete = YES;
        [self handleData];
        [self.tableView.mj_header endRefreshing];
        
    }];
    // 设置文字
   // [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
   // [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    //header.stateLabel.font = [UIFont systemFontOfSize:15];
    //header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    //header.stateLabel.textColor = [UIColor redColor];
   // header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.mj_header = header;
    
    /* 上拉加载 */
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        NSLog(@"正在加载数据");
        self.isDelete = NO;
        self.beginIndex += 10;
        
        [self handleData];
        
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
        
    }];
    self.tableView.mj_footer = footer;
    //[footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    
    
}

#pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

/* 每一个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyTMovie_02_ableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"Movie_sortCell"];
    cell.model = [self.modelArr objectAtIndex:indexPath.section];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // cell.userInteractionEnabled = NO;
    return cell;
}

#pragma mark - 页面将要出现
- (void)viewWillAppear:(BOOL)animated {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 0;
    });
    
    
}

#pragma mark - 页面完成加载
- (void)viewDidLoad {


    [super viewDidLoad];
    self.modelArr = [NSMutableArray array];
    self.beginIndex = 0;
    self.endIndex = 10;
    
    
    [self handleData];
    
    [self createHeadTitleViewAndButtonAndLabelTitle];
    [self createButtonReturn];
    [self createTableView];
    
    
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
