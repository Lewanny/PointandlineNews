
//
//  LhyDiscovery_Detail_ViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/17.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyDiscovery_Detail_ViewController.h"

#import "LhySelected_01_TableViewCell.h"
#import "LhySelected_02_TableViewCell.h"
#import "LhySelected_03_TableViewCell.h"
#import "LhySelected_04_TableViewCell.h"
#import "LhyAutoAdaptHeight.h"
#import "LhyCommunity_SelectedModel.h"
#import "MJRefresh.h"
#import "LhyAFNetworkTool.h"
#import "LhyCommunity_SelectedModel.h"

#import "LhyDiscovery_WebViewController.h"
#import "LhyBaseView.h"

#import "MBProgressHUD.h"

#import "LhyBaseBottomView.h"
#import "ConfigurationTheme.h"

@interface LhyDiscovery_Detail_ViewController ()<UITableViewDelegate, UITableViewDataSource>


@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *modelArr;
@property(nonatomic, assign)BOOL isDelete;

@property(nonatomic, retain)UIButton *buttonReturn;
@property(nonatomic, retain)LhyBaseBottomView *viewBottom;
@property(nonatomic, retain)LhyBaseView *headTitleView;
@property(nonatomic, retain)UILabel *labelTitle;

@property(nonatomic, copy)NSString *nextUrl;
@property(nonatomic, retain)MBProgressHUD *Loading;


@end

@implementation LhyDiscovery_Detail_ViewController



- (void)dealloc {

    [_Loading release];
    [_nextUrl release];
    [_labelTitle release];
    [_headTitleView release];
    [_viewBottom release];
    [_urlStr release];
    [_titleOfHeadView release];

    [_tableView release];
    [_modelArr release];
    [super dealloc];
    
}

#pragma mark - 数据处理
- (void)handelData {
    
    [self.Loading show:YES];
    if (self.isDelete == YES) {
        self.nextUrl = self.urlStr;
        
    }
    
    [LhyAFNetworkTool getUrl:self.nextUrl body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"posts"];
        
        /* 判断试下拉还是刷新 */
        if (self.isDelete == YES) {
            
            [self.modelArr removeAllObjects];
        }
        
        NSMutableDictionary *dicurl = [dic objectForKey:@"info"];
        self.nextUrl = [dicurl objectForKey:@"next_url"];
        
        for (NSMutableDictionary *dic in arr) {
            
            LhyCommunity_SelectedModel *model = [[LhyCommunity_SelectedModel alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            /* 对数据进行相关处理 */
            if (![model.title containsString:@"ZAKER"] && ![model.auther_name containsString:@"ZAKER"] &&![model.content containsString:@"ZAKER"] && ![[model.auther objectForKey:@"name"] isEqualToString:@"话题小秘书"]) {
                
                [self.modelArr addObject:model];
            }
            
            [model release];
        }
        
        /* 完成刷新 */
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.Loading hide:YES];
        });
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
    
}



#pragma mark - 返回按钮和底部View的创建和点击方法
/* 按钮和底部view的创建*/
- (void)createReturnButtonAndButtomView {
    
    /* 底部view */
    self.viewBottom = [[LhyBaseBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
    [self.view addSubview:self.viewBottom];
    self.viewBottom.layer.borderWidth = 1;
    self.viewBottom.layer.borderColor = [UIColor colorWithWhite:0.799 alpha:1.000].CGColor;

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

    [self.navigationController popViewControllerAnimated:YES];
    
        /* 显示两个bar */
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabbar" object:nil];
    
}

#pragma mark - 创建头部视图和titleLabel
- (void)createHeadTitleViewAndButtonAndLabelTitle {
    
    self.headTitleView = [[LhyBaseView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    [self.view addSubview:self.headTitleView];
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 27, 275, 25)];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.text = self.titleOfHeadView;
    [self.headTitleView addSubview:self.labelTitle];
    self.labelTitle.font = [UIFont boldSystemFontOfSize:18];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    
    [self.labelTitle release];
    [self.headTitleView release];
    
}



#pragma mark - 创建tableView 

- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 45, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 30) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    /* 注册四种类型的cell */
    [self.tableView registerClass:[LhySelected_01_TableViewCell class] forCellReuseIdentifier:@"Selected_01_Cell"];
    [self.tableView registerClass:[LhySelected_02_TableViewCell class] forCellReuseIdentifier:@"Selected_02_Cell"];
    [self.tableView registerClass:[LhySelected_03_TableViewCell class] forCellReuseIdentifier:@"Selected_03_Cell"];
    [self.tableView registerClass:[LhySelected_04_TableViewCell class] forCellReuseIdentifier:@"Selected_04_Cell"];
    
}



#pragma mark - TableView协议方法

/* cell的个数 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArr.count;
    
}

/* cell的高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    LhyCommunity_SelectedModel *model = [self.modelArr objectAtIndex:indexPath.row];
    
    /* 自适应文字高度 */
    CGFloat contentHeight = [LhyAutoAdaptHeight heigntForCellWithContent:model.content width:[UIScreen mainScreen].bounds.size.width - 40 fontSize:14];
    if (contentHeight >= 52) {
        contentHeight = 52;
    }
    
    /* 自适应图片高度 */
    //    NSMutableArray *picArr = model.medias;
    //    NSMutableDictionary *picDic = [picArr firstObject];
    //    UIImage *imagePic = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[picDic objectForKey:@"url"]]]];
    //    //NSLog(@"%f", imagePic.size.width);
    //
    //    CGFloat picHeight = [LhyAutoAdaptHeight heigntForCellWithImage:imagePic];
    // NSLog(@"%f", picHeight);
    
    // return 130 + contentHeight + picHeight;
    
    NSMutableDictionary *dicSpeciaInfo = model.special_info;
    NSString *type = [dicSpeciaInfo objectForKey:@"item_type"];
    
    if (type == nil) {
        return 130 + contentHeight;
    } else if ([type isEqualToString:@"1"]){
        
        return 130 + contentHeight + ([UIScreen mainScreen].bounds.size.height- 154) / 2;
        
    } else if ([type isEqualToString:@"2"]) {
        
        return 130 + contentHeight + [UIScreen mainScreen].bounds.size.height / 4;
    } else {
        
        return 130 + contentHeight + [UIScreen mainScreen].bounds.size.height / 5 - 15;
    }
    
    return 100;
}

/* 返回每一个cell */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyCommunity_SelectedModel *model = [self.modelArr objectAtIndex:indexPath.row];
    NSMutableDictionary *dicSpeciaInfo = model.special_info;
    NSString *type = [dicSpeciaInfo objectForKey:@"item_type"];
    
    if (type == nil) {
        
        LhySelected_01_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_01_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
      //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([type isEqualToString:@"1"]){
        
        LhySelected_02_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_02_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
     //   cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else if ([type isEqualToString:@"2"]) {
        
        LhySelected_03_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_03_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
      //  cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    } else {
        
        LhySelected_04_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Selected_04_Cell"];
        cell.backgroundColor = [UIColor colorWithWhite:0.944 alpha:1.000];
        cell.model = [self.modelArr objectAtIndex:indexPath.item];
       // cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    
}


#pragma mark - cell的点击方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyDiscovery_WebViewController *discovery_webVC = [[LhyDiscovery_WebViewController alloc] init];
    discovery_webVC.model = [self.modelArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:discovery_webVC animated:YES];
    
    /* 隐藏两个bar */
    
    
    [discovery_webVC release];
    
    
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

#pragma mark - 界面将要加载
- (void)viewDidLoad {
    [super viewDidLoad];
    
//    /* 注册消息 */
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
//    
//    /* 读取本地文件 */
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
//    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
//    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    
//    /* 主体颜色 */
//    if ([readStr isEqualToString:@"YES"]) {
//        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
//        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
//        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
//  
//        
//    } else {
//        
//        self.tbDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
//        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
//        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
//    }
    

    
    
    
    
    
    // 数据处理前初始化数组
    self.modelArr = [NSMutableArray array];
    self.nextUrl = self.urlStr;
    
    [self handelData];
    [self createTableView];
    [self createReturnButtonAndButtomView];
    [self createHeadTitleViewAndButtonAndLabelTitle];
    
    /* 下拉刷新 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSLog(@"正在刷新数据");
        self.isDelete = YES;
        [self handelData];
        
    }];
    /* 隐藏状态 */
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"Pull down to refresh" forState:MJRefreshStateIdle];
    [header setTitle:@"Release to refresh" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    
    // 设置颜色
    header.stateLabel.textColor = [UIColor redColor];
    header.lastUpdatedTimeLabel.textColor = [UIColor blueColor];
    self.tableView.mj_header = header;
    
    /* 上拉加载 */
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
       // NSLog(@"正在加载数据");
        self.isDelete = NO;
        [self handelData];
        //  [self.tableView reloadData];
        
    }];
    self.tableView.mj_footer = footer;
   // [footer setTitle:@"Click or drag up to refresh" forState:MJRefreshStateIdle];
    [footer setTitle:@"Loading more ..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"No more data" forState:MJRefreshStateNoMoreData];
    

}

///* 改变主题消息 */
//- (void)handleChangeTheme:(NSNotification *)noti {
//    
//    NSString *str = noti.object;
//    if ([str isEqualToString:@"YES"]) {
//        
//        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
//        
//        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
//        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
//      
//        
//    } else {
//        
//        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
//        
//        self.cellDefaultColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
//        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
//   
//    }
//    
//    
//}
//



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
