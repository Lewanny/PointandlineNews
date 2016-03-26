//
//  LhyHotPotViewController.m
//  Maximal
//
//  Created by 李宏远 on 15/11/7.
//  Copyright © 2015年 李宏远. All rights reserved.
//

#import "LhyHotPotViewController.h"
#import "LhyInfoViewController.h"
#import "LhyHotpot_01TableViewCell.h"
#import "LhyHotpot_02TableViewCell.h"
#import "LhyHotpot_03TableViewCell.h"
#import "LhyAFNetworkTool.h"
#import "LhyMainTb_01Model.h"
#import "MJRefresh.h"

#import "LhyHotPot_WebViewController.h"
#import "ConfigurationTheme.h"

#import "MBProgressHUD.h"

@interface LhyHotPotViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, retain)UITableView *tableView;
@property(nonatomic, retain)NSMutableArray *arrModel;
@property(nonatomic, assign)BOOL isDelete;

@property(nonatomic, retain)UIView *addArticalsView;
@property(nonatomic, retain)UILabel *addArticalsLabel;

@property(nonatomic, assign)NSInteger articalNum;

@property(nonatomic, retain)UIColor *defaulrColor;
@property(nonatomic, retain)UIColor *unDefaulrColor;
@property(nonatomic, retain)UIColor *fontColor;

@property(nonatomic, retain)MBProgressHUD *Loading;

@end

@implementation LhyHotPotViewController




- (void)dealloc {
    
    [_arrModel release];
    [_tableView release];
    [_addArticalsView release];
    [_addArticalsLabel release];
    [_Loading release];
    [_fontColor release];
    [_unDefaulrColor release];
    [_defaulrColor release];
    
    [super dealloc];
}


#pragma mark - 数据处理



- (void)handelData {
    
    [self.Loading show:YES];
    [LhyAFNetworkTool getUrl:@"http://hotphone.myzaker.com/daily_hot_new.php?_udid=13F8ECFD-6EF7-4EA5-AECC-CA253B1FA789" body:nil response:LhyJSON requestHeadFile:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableDictionary *dic = [responseObject objectForKey:@"data"];
        NSMutableArray *arr = [dic objectForKey:@"articles"];
        for (NSMutableDictionary *dic in arr) {
            LhyMainTb_01Model *model = [[LhyMainTb_01Model alloc] init];
            [model setValuesForKeysWithDictionary:dic];
            
            /* 对数据进行相关处理 */
            if ([model.title containsString:@"ZAKER"]) {
                model.title = [model.title stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
            }
            if ([model.auther_name containsString:@"ZAKER"]) {
                model.auther_name = [model.auther_name stringByReplacingOccurrencesOfString:@"ZAKER" withString:@"Maximal"];
            }
            
            [self.arrModel addObject:model];
            [model release];
        }
        
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        
        
        [UIView animateWithDuration:0.5 animations:^{
            
            self.addArticalsView.frame = CGRectMake(0, 64, self.view.frame.size.width, 35);
            if (self.arrModel.count != self.articalNum) {
                NSString *str = [NSString stringWithFormat:@"%@%ld%@",@"为您推荐了", self.arrModel.count - self.articalNum, @"篇文章" ];
                self.addArticalsLabel.text = str;
            } else {
                
                self.addArticalsLabel.text = @"暂无最新文章, 请稍后重试";
            }
    
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.5 animations:^{
                [UIView setAnimationDelay:1];
                self.addArticalsView.frame = CGRectMake(0, 29, self.view.frame.size.width, 35);
               
                /* 新数据完成后允许滑动 */
                self.tableView.scrollEnabled = YES;

            }];
        }];
        
        self.articalNum = self.arrModel.count;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            [self.Loading hide:YES];
            
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

/* 创建tableView */
- (void)createTableView {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = self.defaulrColor;
    
    
    [self.tableView registerClass:[LhyHotpot_01TableViewCell class] forCellReuseIdentifier:@"Hotpot_01Cell"];
    [self.tableView registerClass:[LhyHotpot_02TableViewCell class] forCellReuseIdentifier:@"Hotpot_02Cell"];
    [self.tableView registerClass:[LhyHotpot_03TableViewCell class] forCellReuseIdentifier:@"Hotpot_03Cell"];
    
    [self.tableView release];
    
    /* 下拉加载推荐文章 */
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        self.isDelete = YES;
        [self handelData];
        [self.tableView reloadData];
        
    }];

    // 设置文字
    [header setTitle:@"下拉加载推荐文章" forState:MJRefreshStateIdle];
    [header setTitle:@"松开加载推荐文章" forState:MJRefreshStatePulling];
    [header setTitle:@"Loading ..." forState:MJRefreshStateRefreshing];
    
    // 设置字体
    header.stateLabel.font = [UIFont systemFontOfSize:15];
    header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:14];
    header.lastUpdatedTimeLabel.hidden = YES;
    self.tableView.mj_header = header;
    
}

#pragma mark - tableview DataSource协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.arrModel.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    LhyMainTb_01Model *model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
    NSMutableDictionary *dic = model.special_info;
    NSString *type = [dic objectForKey:@"item_type"];
    
    if ([type isEqualToString:@"1"]) {
        return 85;
    } else if ([type isEqualToString:@"3"]){
        return 200;
    }
    return 85;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyMainTb_01Model *model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
    NSMutableDictionary *dic = model.special_info;
    NSString *type = [dic objectForKey:@"item_type"];
   
    if ([type isEqualToString:@"1"]) {
        
        LhyHotpot_02TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hotpot_02Cell"];
        cell.model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
        cell.backgroundColor = self.unDefaulrColor;
        cell.labelTitel.textColor = self.fontColor;
        cell.labelAuthor_name.textColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        return cell;
    } else if ([type isEqualToString:@"3"]){
        
        LhyHotpot_03TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hotpot_03Cell"];
        cell.model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
        cell.backgroundColor = self.unDefaulrColor;
        cell.labelTitel.textColor = self.fontColor;
        cell.labelAuthor_name.textColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        return cell;
    }
    
    LhyHotpot_01TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Hotpot_01Cell"];
    cell.model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
    cell.backgroundColor = self.unDefaulrColor;
    cell.labelTitel.textColor = self.fontColor;
    cell.labelAuthor_name.textColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
    return cell;
    
}

/* 设置footerhea高度 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


/* cell 的点击方法 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LhyMainTb_01Model *model = [self.arrModel objectAtIndex:self.arrModel.count - 1 - indexPath.section];
    LhyHotPot_WebViewController *hotPot_webVC = [[LhyHotPot_WebViewController alloc] init];
    hotPot_webVC.webUrl = model.weburl;
    hotPot_webVC.titleOfArticle = model.title;
    hotPot_webVC.nameOfAuthor = model.auther_name;
    hotPot_webVC.model = model;
    
    NSLog(@"%@", model.title);
    [self.navigationController pushViewController:hotPot_webVC animated:YES];
    
    /* 隐藏两个bar */
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabbar" object:nil];
    
    [hotPot_webVC release];
    
}


#pragma mark- 页面将要出现

- (void)viewWillAppear:(BOOL)animated {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        /* 加载菊花 */
        self.Loading = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        self.Loading.dimBackground = YES;
        self.Loading.animationType = 2;
       
        
    });
    
    /* 注册消息 */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChangeTheme:) name:@"changeTheme" object:nil];
    [self.tableView reloadData];

}

/* 改变主题消息 */
- (void)handleChangeTheme:(NSNotification *)noti {
    
    NSString *str = noti.object;
    if ([str isEqualToString:@"YES"]) {
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        self.unDefaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
    } else {
        
        self.tableView.backgroundColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
        self.unDefaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        
    }
    
}


#pragma mark - 页面将要加载方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    /* 读取本地文件 */
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"Theme.tex"];
    NSString *readStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    /* 主体颜色 */
    if ([readStr isEqualToString:@"YES"]) {
        self.defaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellNewColor"];
        
        self.unDefaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_NewColor"];
        
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontNewColor"];
        
        
    } else {
        
        self.defaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"bgCellDefaultColor"];
        
        self.unDefaulrColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"Cell_01_DefaultColor"];
        
        self.fontColor = [[ConfigurationTheme shareInstance] getThemeColorWithName:@"FontDefaultColor"];
    }
    
    self.arrModel = [NSMutableArray array];
    self.articalNum = 0;
    
    [self handelData];
    [self createTableView];
    [self createViewAndLabel];

    self.navigationItem.title = @"热点";
    /* 导航栏左侧个人信息按钮 */
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"SocialTabBarItemProfile"] style:UIBarButtonItemStylePlain target:self action:@selector(handleInfoButton:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
//    /* 导航栏右侧偏好按钮 */
//    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"DailyHot_PreferencesButton_inDark"] style:UIBarButtonItemStylePlain target:self action:@selector(handlePreferenceButton:)];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}



#pragma mmake - 创建提示的view和label
- (void)createViewAndLabel {
    
    self.addArticalsView = [[UIView alloc] initWithFrame:CGRectMake(0, 29, self.view.frame.size.width, 35)];
    [self.view addSubview:self.addArticalsView];
    self.addArticalsView.backgroundColor = [UIColor grayColor];
    self.addArticalsLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, self.view.frame.size.width - 60, 15)];
    [self.addArticalsView addSubview:self.addArticalsLabel];
    self.addArticalsLabel.textColor = [UIColor whiteColor];
    self.addArticalsLabel.textAlignment = NSTextAlignmentCenter;
    self.addArticalsLabel.font = [UIFont systemFontOfSize:13];
    self.addArticalsView.backgroundColor = [UIColor colorWithWhite:0.215 alpha:0.9];
    
    [self.addArticalsLabel release];
    [self.addArticalsView release];
}


#pragma mark - 两侧按钮的点击方法
/* 点击info按钮的方法 */
- (void)handleInfoButton:(UITabBarItem *)barItem {
    
    LhyInfoViewController *infoVC = [[LhyInfoViewController alloc] init];
    [self.navigationController pushViewController:infoVC animated:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hideTabbar" object:nil];
    [infoVC release];
    
}

///* 点击偏好按钮 */
//- (void)handlePreferenceButton:(UIButton *)button {
//    
//    
//}

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
